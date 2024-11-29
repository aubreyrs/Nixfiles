{ config, pkgs, ... }: {
  imports = [ 
    ./hardware-configuration.nix
    ./modules/desktop
    ./modules/networking.nix
    <home-manager/nixos>
  ];

  home-manager.users.aubrey = { pkgs, ... }: {
    home.pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };
  };

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    fontconfig = {
      enable = true;
      useEmbeddedBitmaps = true;
      defaultFonts = {
        serif = [ "Liberation Serif" "Noto Serif" "Noto Color Emoji" ];
        sansSerif = [ "Inter" "Liberation Sans" "Noto Sans" "Noto Color Emoji" ];
        monospace = [ "Cozette" "JetBrains Mono" "Liberation Mono" "Noto Sans Mono" ];
        emoji = ["Noto Color Emoji"];
      };
      antialias = true;
      hinting.enable = true;
      hinting.style = "slight";
      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };
    };

    packages = with pkgs; [
      liberation_ttf noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
      cozette jetbrains-mono fira-code fira-code-symbols hack-font victor-mono
      inter roboto roboto-mono ubuntu_font_family font-awesome
      material-design-icons material-icons noto-fonts-lgc-plus dejavu_fonts
      freefont_ttf gyre-fonts
      (nerdfonts.override { fonts = [
        "JetBrainsMono" "FiraCode" "Hack" "SpaceMono" "DroidSansMono" "VictorMono"
      ]; })
    ];
  };
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  time.timeZone = "Europe/London";
  
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  users.users.aubrey = {
    isNormalUser = true;
    description = "aubrey";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05";
}