{ pkgs, ... }:

let
  gtk_config = {
    Settings = ''
      gtk-application-prefer-dark-theme=1
    '';
  };
in

{
  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    cursorTheme = {
      name = "elementary";
      package = pkgs.elementary-xfce-icon-theme;
      size = 16;
    };
    iconTheme = {
      name = "elementary-Xfce-dark";
      package = pkgs.elementary-xfce-icon-theme;
    };
    gtk3.extraConfig = gtk_config;
    gtk4.extraConfig = gtk_config;
    theme = {
      name = "zukitre-dark";
      package = pkgs.zuki-themes;
    };
  };

  home = {
    packages = with pkgs; [
      authenticator
      beekeeper-studio
      bitwarden
      cantarell-fonts
      dbeaver
      devdocs-desktop
      dialect
      epiphany
      gitg
      ibm-plex
      inriafonts
      keepassxc
      liferea
      medio
      meld
      microsoft-edge
      pika-backup
      poly
      remmina
      gnome-secrets
      seafile-client
      shortwave
      surf
      thunderbird
      vegur
      vial
      virt-manager
      work-sans
      zeal
      (nerdfonts.override { fonts = [ "IBMPlexMono"  "Overpass" ]; })
    ];
  };

  programs = {
    gpg.enable = true;
  };

  services.gpg-agent.enable = true;
}
