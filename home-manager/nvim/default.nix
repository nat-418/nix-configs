# Neovim text editor configuration.
{ pkgs, ... }:

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
      neovim-remote
    ];
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
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
