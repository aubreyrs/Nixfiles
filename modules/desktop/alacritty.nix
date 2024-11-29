{ config, pkgs, ... }: {
  home-manager.users.aubrey = { pkgs, ... }: {
    programs.alacritty = {
      enable = true;
      settings = {
        font = {
          normal.family = "CozetteVector";
          normal.style = "Regular";
          bold.family = "CozetteVector";
          bold.style = "Regular";
          italic.family = "CozetteVector";
          italic.style = "Regular";
          bold_italic.family = "CozetteVector";
          bold_italic.style = "Regular";
          size = 14.0;
        };

        window = {
          padding.x = 15;
          padding.y = 15;
          decorations = "full";
          dynamic_title = true;
        };

        cursor = {
          style = {
            shape = "Beam";
            blinking = "On";
          };
          unfocused_hollow = true;
        };

        env.TERM = "xterm-256color";

        shell = {
          program = "${pkgs.fish}/bin/fish";
          args = ["--login"];
        };

        colors = {
          primary = {
            background = "#282828";
            foreground = "#d4be98";
          };
          normal = {
            black = "#3c3836";
            red = "#ea6962";
            green = "#a9b665";
            yellow = "#d8a657";
            blue = "#7daea3";
            magenta = "#d3869b";
            cyan = "#89b482";
            white = "#d4be98";
          };
          bright = {
            black = "#3c3836";
            red = "#ea6962";
            green = "#a9b665";
            yellow = "#d8a657";
            blue = "#7daea3";
            magenta = "#d3869b";
            cyan = "#89b482";
            white = "#d4be98";
          };
        };
      };
    };
  };
}
