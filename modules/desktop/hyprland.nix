{ config, pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    
    users.aubrey = { pkgs, ... }: {
      home.stateVersion = "24.05";
      
      xdg.configFile."hypr/hyprpaper.conf".text = ''
        preload = ${config.users.users.aubrey.home}/.config/hypr/wallpapers/gruvbox_wall.png
        wallpaper = eDP-1,${config.users.users.aubrey.home}/.config/hypr/wallpapers/gruvbox_wall.png
        ipc = off
        splash = false
      '';

      home.file.".config/hypr/wallpapers/gruvbox_wall.png".source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/FrenzyExists/wallpapers/main/Pixelart/gruvbox_image46.png";
        sha256 = "00qiw2qjrz9vwkxz5hid8i6f2fb8cmnrkii1ycin81pkw21pdxlm";
      };
      
      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = true;
        systemd.variables = ["--all"];
        xwayland.enable = true;

        settings = {
          "$terminal" = "alacritty";
          "$fileManager" = "dolphin";
          "$menu" = "wofi --show drun";
          "$mainMod" = "ALT";

          monitor = [ "eDP-1, preferred, auto, 1.5" ];

          workspace = [
            "1,monitor:eDP-1,default:true,on-created-empty:$terminal"
            "2,monitor:eDP-1"
            "3,monitor:eDP-1"
            "4,monitor:eDP-1"
            "5,monitor:eDP-1"
          ];
          
          exec-once = [
            "wl-clipboard-history -t"
            "hyprpaper"
            "xsettingsd"
          ];

          env = [
            "XCURSOR_SIZE,20"
            "HYPRCURSOR_SIZE,24"
            "XDG_CURRENT_DESKTOP,Hyprland"
            "XDG_SESSION_TYPE,wayland"
            "XDG_SESSION_DESKTOP,Hyprland"
          ];

          general = {
            gaps_in = 5;
            gaps_out = 8;
            border_size = 2;
            "col.active_border" = "rgba(a9b665ff)";
            "col.inactive_border" = "rgba(7c6f64ff)";
            layout = "dwindle";
            resize_on_border = true;
            extend_border_grab_area = 15;
            hover_icon_on_border = true;
            no_focus_fallback = false;
          };

          decoration = {
            rounding = 0;
            active_opacity = 0.95;
            inactive_opacity = 0.85;
            blur = {
              enabled = true;
              size = 5;
              passes = 2;
              new_optimizations = true;
              ignore_opacity = true;
              xray = true;
            };
            drop_shadow = false;
          };

          animations = {
            enabled = true;
            bezier = [
              "myBezier, 0.05, 0.9, 0.1, 1.05"
              "linear, 0.0, 0.0, 1.0, 1.0"
            ];
            animation = [
              "windows, 1, 4, myBezier"
              "windowsOut, 1, 4, default, popin 80%"
              "border, 1, 10, default"
              "borderangle, 1, 8, linear, loop"
              "fade, 1, 5, default"
              "workspaces, 1, 3, default, slide"
            ];
          };

          input = {
            kb_layout = "gb";
            follow_mouse = 1;
            sensitivity = 0;
            touchpad = {
              natural_scroll = false;
              disable_while_typing = true;
              drag_lock = true;
              clickfinger_behavior = true;
              middle_button_emulation = true;
              tap-to-click = true;
            };
          };

          gestures = {
            workspace_swipe = true;
            workspace_swipe_fingers = 3;
            workspace_swipe_distance = 300;
            workspace_swipe_invert = false;
            workspace_swipe_min_speed_to_force = 30;
            workspace_swipe_cancel_ratio = 0.5;
            workspace_swipe_create_new = false;
          };

          misc = {
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
            force_default_wallpaper = 0;
            vfr = true;
            vrr = 0;
            mouse_move_enables_dpms = true;
            key_press_enables_dpms = true;
            disable_autoreload = true;
            close_special_on_empty = true;
            new_window_takes_over_fullscreen = 2;
            focus_on_activate = true;
          };

          bind = [
            "$mainMod, RETURN, exec, $terminal"
            "$mainMod SHIFT, Q, killactive"
            "$mainMod, M, exit"
            "$mainMod, E, exec, $fileManager"
            "$mainMod, V, togglefloating"
            "$mainMod, tab, exec, tofi-drun --drun-launch=true --fuzzy-match=true"
            "$mainMod, P, pseudo"
            "CTRL SHIFT, S, exec, grimblast --notify copysave area"
            "CTRL ALT, S, exec, grimblast --notify save output"
            "$mainMod, left, movefocus, l"
            "$mainMod, right, movefocus, r"
            "$mainMod, up, movefocus, u"
            "$mainMod, down, movefocus, d"
            "$mainMod, 1, workspace, 1"
            "$mainMod, 2, workspace, 2"
            "$mainMod, 3, workspace, 3"
            "$mainMod, 4, workspace, 4"
            "$mainMod, 5, workspace, 5"
            "$mainMod SHIFT, 1, movetoworkspace, 1"
            "$mainMod SHIFT, 2, movetoworkspace, 2"
            "$mainMod SHIFT, 3, movetoworkspace, 3"
            "$mainMod SHIFT, 4, movetoworkspace, 4"
            "$mainMod SHIFT, 5, movetoworkspace, 5"
            ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
            ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
            ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
            ",XF86AudioNext, exec, playerctl next"
            ",XF86AudioPause, exec, playerctl play-pause"
            ",XF86AudioPlay, exec, playerctl play-pause"
            ",XF86AudioPrev, exec, playerctl previous"
          ];

          bindm = [
            "$mainMod, mouse:272, movewindow"
            "$mainMod, mouse:273, resizewindow"
          ];

          windowrulev2 = [
            "noblur, class:^(firefox)$"
            "noshadow, class:^(firefox)$"
            "noborder, class:^(firefox)$"
            "opaque, class:^(firefox)$"
            "forcergbx, class:^(firefox)$"
            "float, class:^(pavucontrol)$"
            "float, class:^(blueman-manager)$"
            "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
          ];
        };
      };

      home.packages = with pkgs; [
        dunst libnotify wl-clipboard wofi grim slurp brightnessctl
        playerctl hyprpaper xsettingsd grimblast
      ];
    };
  };
}