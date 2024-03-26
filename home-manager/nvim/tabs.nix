{ ... }:

let
  fromGitHub = import ../functions/fromGitHub.nix;
in

{
  programs.neovim = {
    plugins = [
      (fromGitHub {user = "echasnovski"; repo = "mini.tabline";})
      (fromGitHub {user = "nat-418";     repo = "tabbot.nvim";})
    ];
    extraLuaConfig = /* lua */ ''
      require('mini.tabline').setup({})
      require('tabbot').setup()

      vim.keymap.set('n', '<M-0>', '<Cmd>Tabbot clear<CR>', {desc = 'Clear empty tabs'})
      vim.keymap.set('n', '<M-1>', '<Cmd>Tabbot go 1<CR>',  {desc = 'Go to tab number 1'})
      vim.keymap.set('n', '<M-2>', '<Cmd>Tabbot go 2<CR>',  {desc = 'Go to tab number 2'})
      vim.keymap.set('n', '<M-3>', '<Cmd>Tabbot go 3<CR>',  {desc = 'Go to tab number 3'})
      vim.keymap.set('n', '<M-4>', '<Cmd>Tabbot go 4<CR>',  {desc = 'Go to tab number 4'})
      vim.keymap.set('n', '<M-5>', '<Cmd>Tabbot go 5<CR>',  {desc = 'Go to tab number 5'})
      vim.keymap.set('n', '<M-6>', '<Cmd>Tabbot go 6<CR>',  {desc = 'Go to tab number 6'})
      vim.keymap.set('n', '<M-7>', '<Cmd>Tabbot go 7<CR>',  {desc = 'Go to tab number 7'})
      vim.keymap.set('n', '<M-8>', '<Cmd>Tabbot go 8<CR>',  {desc = 'Go to tab number 8'})
      vim.keymap.set('n', '<M-9>', '<Cmd>Tabbot go 9<CR>',  {desc = 'Go to tab number 9'})
    '';
  };
}
