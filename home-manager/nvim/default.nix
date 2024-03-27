# Neovim text editor configuration.
{ pkgs, ... }:

let
  neovide-shim = pkgs.writeShellScriptBin "neovide-shim" ''
    exec ${pkgs.neovide}/bin/neovide --multigrid "$@"
  '';
in

{
  imports = [
    ./buffers.nix
    ./colorscheme.nix
    ./completion.nix
    ./debug.nix
    ./fuzzy.nix
    ./git.nix
    ./hlargs.nix
    ./lsp.nix
    ./motions.nix
    ./quickfix.nix
    ./syntax.nix
    ./tabs.nix
    ./treesitter.nix
    ./undo.nix
    ./wiki.nix
    ./windows.nix
    ./first.nix
  ];

  home = {
    packages = with pkgs; [
      neovide
      neovim-remote
    ];
    sessionVariables = {
      EDITOR = "${neovide-shim}/bin/neovide-shim";
      VISUAL = "${neovide-shim}/bin/neovide-shim";
    };
  };

  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
}
