# This file contains shell-specific configuration, includting a few
# command-line tools that integrate tightly with the shell.
{ pkgs, config, ... }:

{
  home = {
    file = {
      "todo.txt" = {
        enable = true;
        source = config.lib.file.mkOutOfStoreSymlink ./todo/todo.txt;
      };
      ".todo/config" = {
        enable = true;
        source = config.lib.file.mkOutOfStoreSymlink ./todo/config;
      };
    };
    packages = with pkgs; [
      bottom       # better top
      todo-txt-cli # task manager
      trash-cli    # rm for the sane
      xsel         # NOTE: eventually replace with another clipboard manager
    ];
  };
  programs = {
    # Improved CTRL-R
    atuin = {
      enable = true;
      enableBashIntegration = true; # Sometimes we need it
      enableFishIntegration = true;
      flags = [ "--disable-up-arrow" ];
      settings = {
        auto_sync = true;
        invert = true;
        sync_address = "${config.home.sessionVariables.ATUIN_SYNC_SERVER}";
        sync_frequency = "5m";
      };
    };
    # Improved pager
    bat = {
      config = {
        theme = "gruvbox-dark";
      };
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batgrep
        batwatch
      ];
    };
    # Improved tab completion
    carapace = {
      enable = true;
      enableFishIntegration = true;
    };
    # Improved ls
    eza = {
      enable = true;
      enableAliases = true;
      # Re-enable after upgrade to next / unstable:
      # enableFishIntegration = true;
      git = true;
      icons = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };
    # Friendly Interactive SHell
    fish = {
      enable = true;
      interactiveShellInit = "
        set fish_greeting
      ";
      plugins = [
        {
          name = "fzf.fish";
          src = pkgs.fishPlugins.fzf-fish.src;
        }
      ];
      functions = {
        # Fuzzy-finder that doesn't interrupt terminal flow
        fz = ''
          fzf --multi --reverse
        '';
        # Fuzzy-finder with colourful file preview
        fzp = ''
          fzf --multi --reverse \
              --preview-window=down \
              --preview="bat --color=always --plain {}"
        '';
        # Fuzzy-finder for navigating filesystem
        fc = ''
          set directory (fd --type=directory . $argv[1] | fz || echo "")
          if test $directory != ""
            cd $directory
          end
        '';
        # Fuzzy-finder for navigating filesystem, ignoring nothing.
        fca = ''
          set directory (
            fd --no-ignore --hidden --type=directory . $argv[1] | fz || echo ""
          )
          if test $directory != ""
            cd $directory
          end
        '';
        # Fuzzy-finder to open files in a text editor
        fed = ''
          set file (fd --type=file . $argv[1] | fzp || echo "")
          if test $file != ""
            $EDITOR $file
          end
        '';
      };
      shellInit = "
        # Throw scripts in here
        fish_add_path ~/.local/share/bin/
        # Integration with nix-shell
        any-nix-shell fish --info-right | source
      ";
      shellAbbrs = {
        # replace with wl-clipboard or whatever for Wayland
        # if there is no Xwayland available.
        copy = "xsel --input --clipboard <";
        hm   = "home-manager";
        hms  = "home-manager switch -b (date +%Y-%m-%d:%T)";
        ls   = "eza";
        man  = "batman";
        nrs  = "sudo nixos-rebuild switch";
        ns   = "nix-shell";
        nsp  = "nix-shell --pure";
        psl  = "btm --expanded --default_widget_type=proc";
        pst  = "btm --expanded --default_widget_type=proc --tree";
        rm   = "trash";
        t    = "todo.sh";
        vic  = "fed ~/Code/";
        vih  = "fed ~/.config/home-manager/";
        viH  = "fed ~";
        vin  = "fed ~/.config/home-manager/nvim/";
        viw  = "fed ~/Documents/Wiki/";
        vix  = "fed /etc/nixos/";
        sys  = "systemctl";
        syu  = "systemctl --user";
      };
    };
    # Fuzzy-finder
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
