{ fromGitHub, ... }:

{
  programs.neovim = {
    plugins = [
      (fromGitHub {user = "echasnovski";   repo = "mini.ai";})
      (fromGitHub {user = "michaeljsmith"; repo = "vim-indent-object";})
    ];
    extraLuaConfig = /* lua */ ''
      require('mini.ai').setup({})
    '';
  };
}
