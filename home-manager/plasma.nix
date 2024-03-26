# KDE Plasma 5 desktop apps, etc.
{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home = {
    packages = with pkgs; [
      beekeeper-studio
      bitwarden
      cantarell-fonts
      dbeaver
      ibm-plex
      inriafonts
      inter
      keepassxc
      libertine
      libsForQt5.yakuake
      libaacs
      lxqt.qterminal
      nheko
      protonmail-bridge
      rssguard
      seafile-client
      supersonic
      thunderbird
      transmission-qt
      ungoogled-chromium
      vegur
      vial
      virt-manager
      work-sans
      yubikey-manager-qt
      zeal
      (nerdfonts.override { fonts = [ "IBMPlexMono"  "Overpass" ]; })
    ];
  };

  programs = {
    gpg.enable = true;
  };

  services.gpg-agent.enable = true;
}
