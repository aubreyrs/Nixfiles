{ config, pkgs, ... }: {
  programs.fish.enable = true;

  home-manager.users.aubrey = { pkgs, ... }: {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting
        starship init fish | source
        set -gx EDITOR micro
        set -gx VISUAL $EDITOR
        set -gx PAGER less
        set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
        set -gx MICRO_TRUECOLOR 1
        set -gx PATH $HOME/.cargo/bin $PATH
        set -Ux fish_user_paths $HOME/bin $fish_user_paths

        if type -q fzf
          set -gx FZF_DEFAULT_COMMAND "fd --type file --follow --hidden --exclude .git"
          set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
          fzf_key_bindings
        end

        if type -q zoxide
          zoxide init fish | source
        end

        if type -q thefuck
          thefuck --alias | source
        end

        if test -f ~/.config/fish/local.fish
          source ~/.config/fish/local.fish
        end

        for file in ~/.config/fish/functions/*.fish
          source $file
        end
      '';

      shellAliases = {
        ls = "exa --icons --group-directories-first";
        ll = "exa -l --icons --group-directories-first";
        la = "exa -la --icons --group-directories-first";
        tree = "exa --tree --icons";
        cat = "bat";
        g = "git";
      };

      functions = {
        mkcd.description = "Create a directory and change into it";
        mkcd.body = "mkdir -p $argv && cd $argv";
      };

      plugins = [
        { name = "fzf"; src = pkgs.fishPlugins.fzf-fish.src; }
        { name = "foreign-env"; src = pkgs.fishPlugins.foreign-env.src; }
      ];
    };

    home.packages = with pkgs; [
      micro bat eza fd fzf zoxide thefuck starship
    ];

    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };

    home.file.".config/fish/functions/.keep".text = "";
  };
}