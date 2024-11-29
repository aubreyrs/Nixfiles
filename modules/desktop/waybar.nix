{ config, pkgs, ... }: {
  home-manager.users.aubrey = { pkgs, ... }: {
    programs.waybar = {
      enable = true;
      systemd = {
        enable = true;
        target = "hyprland-session.target";
      };
      settings = {
        mainBar = {
          layer = "bottom";
          position = "bottom";
          height = 44;
          spacing = 0;
          output = ["eDP-1"];
          
          modules-left = ["hyprland/workspaces" "cpu"];
          modules-center = ["mpris"];
          modules-right = ["memory" "network" "pulseaudio" "clock"];

          "hyprland/workspaces" = {
            format = "{icon}";
            "on-click" = "activate";
            "format-icons" = {
              active = "󰝤";
              default = "󰝣";
            };
            "persistent-workspaces" = {
              "1" = [];
              "2" = [];
              "3" = [];
              "4" = [];
              "5" = [];
            };
          };
          
          clock = {
            format = "{:%H:%M}";
            "tooltip-format" = "{:%A, %d %B %Y}";
          };

          cpu.format = "CPU {usage}%";
          cpu.interval = 2;

          memory.format = "RAM {percentage}%";
          memory.interval = 2;

          network = {
            format = "NET {bandwidthDownBits}";
            "format-disconnected" = "OFFLINE";
            interval = 2;
          };

          pulseaudio = {
            format = "VOL {volume}%";
            "format-muted" = "MUTE";
            "on-click" = "pavucontrol";
          };

          mpris = {
            format = "{artist} - {title}";
            "format-paused" = "[PAUSE] {artist} - {title}";
            "max-length" = 50;
          };
        };
      };

      style = ''
        @define-color bg_h   #1d2021;
        @define-color bg0    #282828;
        @define-color bg1    #3c3836;
        @define-color bg2    #504945;
        @define-color bg3    #665c54;
        @define-color bg4    #7c6f64;
        @define-color fg0    #fbf1c7;
        @define-color fg1    #ebdbb2;
        @define-color fg2    #d5c4a1;
        @define-color fg3    #bdae93;
        @define-color fg4    #a89984;
        @define-color red    #ea6962;
        @define-color green  #a9b665;
        @define-color yellow #d8a657;
        @define-color blue   #7daea3;
        @define-color purple #d3869b;
        @define-color aqua   #89b482;
        @define-color orange #e78a4e;
        @define-color gray   #928374;

        * {
          border: none;
          border-radius: 0;
          font-family: "CozetteVector";
          font-size: 15px;
          min-height: 0;
          margin: 0;
          padding: 0;
        }

        window#waybar {
          background: @bg_h;
          color: @fg1;
        }

        #workspaces {
          background: @bg0;
          margin: 4px;
          padding: 0 2px;
        }

        #workspaces button {
          color: @fg4;
          padding: 0 4px;
          margin: 4px 2px;
        }

        #workspaces button.active {
          color: @fg0;
        }

        #workspaces button:hover {
          color: @fg0;
        }

        #workspaces button.urgent {
          color: @red;
        }

        #mpris,
        #network,
        #cpu,
        #memory,
        #clock,
        #pulseaudio {
          background: @bg0;
          color: @fg1;
          padding: 0 8px;
          margin: 4px 2px;
        }

        #network { color: @blue; }
        #cpu { color: @green; }
        #memory { color: @yellow; }
        #clock { color: @fg0; }
        #pulseaudio { color: @aqua; }

        tooltip {
          background: @bg0;
          border: 1px solid @bg2;
        }

        tooltip label {
          color: @fg1;
        }
      '';
    };
  };
}