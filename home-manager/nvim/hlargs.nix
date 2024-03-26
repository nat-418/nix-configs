{ ... }:

let
  fromGitHub = import ../functions/fromGitHub.nix;
in

{
  programs.neovim = {
    plugins = [
      (fromGitHub {user = "m-demare"; repo = "hlargs.nvim";})
    ];
    extraLuaConfig = /* lua */ ''
      require('hlargs').setup()
    '';
  };
}
