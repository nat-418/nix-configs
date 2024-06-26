# This file contains command-line tools, principally ones that are less tightly
# integrated with the shell.
{pkgs, ...}:

let
  # My personal software repository. To use, run:
  # nix-channel --add https://github.com/nat-418/grimoire/archive/main.tar.gz grimoire
  grimoire = import <grimoire> {};
in

{
  home = {
    packages = (with grimoire; [
      clonetrees
      knock
      hogs
    ]) ++ (with pkgs; [
      abduco
      age
      ali
      ansible
      any-nix-shell
      bc
      bfs
      bitwarden-cli
      chafa
      dejagnu
      delta
      dig
      diskus
      docker-compose
      duckdb
      dvtm
      entr
      expect
      fd
      felix-fm
      ffmpeg
      file
      fossil
      gnumake
      hexyl
      highlight
      hyperfine
      ijq
      imagemagick
      incrtcl
      inetutils
      jimtcl
      just
      lazydocker
      litemdview
      lynx
      miniserve
      moreutils
      nagelfar
      nil
      nmap
      plantuml
      p7zip
      postgresql
      poppler_utils
      python3Full
      qrencode
      rbw
      s3cmd
      screen
      sd
      shellcheck
      sqlar
      sqlite
      sqlitebrowser
      sshuttle
      tcl
      tcllib
      tclreadline
      tcltls
      tclx
      terraform
      tix
      tk
      tkrev
      ttdl
      unrar-wrapper
      unzip
      usbutils
      usql
      w3m
      wrk
      wget
      ueberzugpp
      yewtube
      zig
      zip
      zlib
    ]);
  };

  programs = {
    aria2.enable = true;
    go = {
      enable = true;
      goPath = "$HOME/.go";
    };
    gpg.enable = true;
    # Try this out once Himalaya hits 1.0.0
    # himalaya = {
    #   enable = true;
    # };
    home-manager.enable = true;
    jq.enable = true;
    navi = {
      enable = true;
      enableFishIntegration = true;
    };
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
    pandoc.enable = true;
    # Investigate this later
    # papis = {
    #   enable = true;
    #   libraries = {
    #     books = {
    #       isDefault = true;
    #       name = "books";
    #       settings = {
    #         dir = "~/Documents/books/";
    #       };
    #     };
    #   };
    # };
    password-store = {
      enable = true;
    };
    pet = {
      enable = true;
      selectcmdPackage = pkgs.fzf;
    };
    ripgrep.enable = true;
    ssh.enable = true;
    tealdeer = {
      enable = true;
      settings = {
        auto_update = true;
      };
    };
    texlive = {
      enable = true;
      packageSet = pkgs.texlive;
    };
    translate-shell.enable = true;
    yazi = {
      enable = true;
      enableFishIntegration = true;
    };
    yt-dlp.enable = true;
    zellij.enable = true;
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
  };
}
