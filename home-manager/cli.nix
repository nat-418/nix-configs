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
      gitlab-runner
      gnumake
      hexyl
      hyperfine
      ijq
      imagemagick
      incrtcl
      inetutils
      jimtcl
      just
      lazydocker
      lazygit
      litemdview
      lynx
      miniserve
      moreutils
      nagelfar
      nil
      nmap
      plantuml
      postgresql
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
      unzip
      usbutils
      usql
      w3m
      wrk
      wget
      yewtube
      zig
      zip
      zlib
    ]);
  };

  programs = {
    aria2.enable = true;
    broot.enable = true;
    git-cliff.enable = true;
    git = {
      enable = true;
      delta.enable = true;
      signing = {
        signByDefault = false;
        key = null;
      };
    };
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
      # packageSet = pkgs.texlive.combined.scheme-full;
    };
    translate-shell.enable = true;
    yt-dlp.enable = true;
    zellij.enable = true;
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
  };
}
