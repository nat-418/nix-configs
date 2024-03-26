# Plasma 5 desktop environment setup
{ pkgs, ... }:

{
  environment = {
    sessionVariables = {
      SSH_ASKPASS_REQUIRE="prefer";
    };
    systemPackages = with pkgs; [
      appimage-run
      audacity
      digikam
      filelight
      firefox
      glaxnimate
      glib
      haruna
      handbrake
      isoimagewriter
      kalendar
      makemkv
      caffeine-ng
      kate
      kdenlive
      keysmith
      killall
      kolourpaint
      krita
      libaacs
      libbluray
      libreoffice-qt
      libsForQt5.booth
      libsForQt5.k3b
      libsForQt5.kalk
      libsForQt5.kasts
      libsForQt5.kcolorchooser
      libsForQt5.kdialog
      libsForQt5.krdc
      libsForQt5.krecorder
      libsForQt5.krunner-ssh
      libsForQt5.marble
      libsForQt5.plasma-browser-integration
      libsForQt5.skanlite
      krunner-translator
      mediainfo
      thunderbird
      vorta
      wacomtablet
    ];
  };

  hardware = {
    bluetooth.enable = true;
    opengl.enable = true;
    pulseaudio.enable = false;
  };

  programs = {
    partition-manager.enable = true;
    xwayland.enable = true;
    ssh = {
      startAgent = true;
      askPassword = pkgs.lib.mkForce "${pkgs.ksshaskpass.out}/bin/ksshaskpass";
    };
  };

  security = {
    apparmor.enable = true;
    rtkit.enable = true;
  };

  services = {
    avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
    };
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
    };
    printing.enable = true;
    xserver = {
      enable = true;
      excludePackages = with pkgs; [
        xterm
      ];
      layout = "us";
      xkbVariant = "";
      displayManager.sddm= {
        enable = true;
        wayland.enable = true;
      };
      desktopManager.plasma5 = {
        enable = true;
        runUsingSystemd = true;
        useQtScaling = true;
      };
    };
  };

  sound.enable = true;

  systemd.user.services.add_ssh_keys = {
    script = ''
      ssh-add $HOME/.ssh/id_rsa
    '';
    wantedBy = [ "multi-user.target" ];
  };
}
