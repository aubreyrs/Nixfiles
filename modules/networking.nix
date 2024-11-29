{ config, pkgs, ... }: {
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  age.secrets.wifi-password = {
    file = ../modules/secrets/wifi-password.age;
    owner = "root";
    group = "networkmanager";
    mode = "0440";
  };

  networking = {
    hostName = "nixos";
    
    networkmanager = {
      enable = true;
      wifi.macAddress = "random";
      ensureProfiles.profiles = {
        Sushi = {
          connection = {
            id = "Sushi";
            type = "wifi";
            autoconnect = true;
          };
          wifi = {
            ssid = "Sushi";
            mode = "infrastructure";
          };
          wifi-security = {
            auth-alg = "open";
            key-mgmt = "wpa-psk";
            psk = config.age.secrets.wifi-password.path;
          };
        };
      };
    };

    nat = {
      enable = true;
      enableIPv6 = true;
      externalInterface = "wlp3s0";
      internalInterfaces = [ "enp0s31f6" ];
    };

    interfaces.enp0s31f6.ipv4.addresses = [{
      address = "192.168.2.1";
      prefixLength = 24;
    }];

    firewall = {
      allowedTCPPorts = [ 44 53 67 68 ];
      allowedUDPPorts = [ 53 67 68 ];
      extraCommands = ''
        iptables -A FORWARD -i enp0s31f6 -j ACCEPT
        iptables -A FORWARD -o enp0s31f6 -j ACCEPT
        iptables -t nat -A POSTROUTING -o wlp3s0 -j MASQUERADE
      '';
    };
  };

  services = {
    openssh = {
      enable = true;
      ports = [ 44 ];
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "no";
        AllowUsers = [ "aubrey" ];
      };
    };

    dnsmasq = {
      enable = true;
      settings = {
        interface = "enp0s31f6";
        bind-interfaces = true;
        dhcp-range = "192.168.2.100,192.168.2.200,24h";
        dhcp-option = [
          "option:router,192.168.2.1"
          "option:dns-server,8.8.8.8"
          "option:dns-server,8.8.4.4"
        ];
      };
    };
  };

  programs.nm-applet.enable = true;
}