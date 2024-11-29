{ config, pkgs, ... }: {
  imports = [
    ./hyprland.nix
    ./alacritty.nix
    ./fish.nix
    ./tofi.nix
    ./waybar.nix
  ];

  services.xserver = {
    enable = true;
    xkb.layout = "gb";
    xkb.variant = "";
  };

  console.keyMap = "uk";

  hardware = {
    pulseaudio.enable = false;
    graphics.enable = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.printing.enable = true;
  programs.firefox.enable = true;
  programs.dconf.enable = true;

  environment = {
    sessionVariables = {
      XCURSOR_SIZE = "20";
      HYPRCURSOR_SIZE = "24";
    };
    systemPackages = with pkgs; [
      discord micro wl-clipboard xdg-utils grim slurp vscode code2prompt
    ];
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
}
