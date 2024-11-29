{ config, pkgs, ... }: {
  home-manager.users.aubrey = { pkgs, ... }: {
    programs.tofi = {
      enable = true;
      settings = {
        text-color = "#ebdbb2";
        prompt-color = "#d79921";
        selection-color = "#504945";
        background-color = "#282828";
        width = "100%";
        height = "100%";
        border-width = 0;
        outline-width = 0;
        padding-top = "30%";
        padding-bottom = "30%";
        padding-left = "8%";
        padding-right = "8%";
        result-spacing = 25;
        num-results = 5;
        font = "SpaceMono Nerd Font";
        clip-to-padding = true;
        hide-cursor = true;
      };
    };
  };
}