# This is an example file.
{ ... }:

{
  imports = [
    ./alacritty.nix
    ./cli.nix
    ./firefox.nix
    # When a directory has a default.nix in it,
    # you can just import the directory like this:
    ./nvim
    ./plasma.nix
    ./rio.nix
    ./shell.nix
    # ./xfce.nix
  ];

  # Home Manager documentation
  manual = {
    manpages.enable = false;
    html.enable = true;
    json.enable = false;
  };

  home = {
    username = "example";
    homeDirectory = "/home/example";
    keyboard.options = [
      "ctrl:nocaps"
    ];
    stateVersion = "23.11";
    sessionVariables = {
      ATUIN_SYNC_SERVER = "https://atuin.example.com";
      LIBVIRT_DEFAULT_URI = "qemu:///system";
    };
  };

  nixpkgs.config.allowUnfree = true;
}
