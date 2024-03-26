{ pkgs, ... }:

let
  fromGitHub = import ../functions/fromGitHub.nix;
in

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vim-fugitive
      gitsigns-nvim
      (fromGitHub {user = "akinsho"; repo = "git-conflict.nvim";})
    ];
    extraLuaConfig = /* lua */ ''
      require('gitsigns').setup()
      require('git-conflict').setup({
        disable_diagnostics = true,
        highlights = {
          incoming = "DiffAdd",
          current = "DiffText"
        }
      })
      vim.keymap.set('n', '<Leader>fg', '<Cmd>AdvancedGitSearch<CR>',     {desc = 'Fuzzy-find git'})
      vim.keymap.set('n', '<Leader>gb', '<Cmd>Gitsigns blame_line<CR>',   {desc = 'Peek git blame'})
      vim.keymap.set('n', '<Leader>gB', '<Cmd>Git blame<CR>',             {desc = 'Open git blame'})
      vim.keymap.set('n', '<Leader>go', '<Cmd>GBrowse<CR>',               {desc = 'Browse git repository'})
      vim.keymap.set('n', '<Leader>gc', '<Cmd>Git commit<CR>',            {desc = 'Commit git changes'})
      vim.keymap.set('n', '<Leader>gd', '<Cmd>Git diff<CR>',              {desc = 'Open git diff'})
      vim.keymap.set('n', '<Leader>gl', '<Cmd>Git log<CR>',               {desc = 'Open git log'})
      vim.keymap.set('n', '<Leader>gg', '<Cmd>Git status<CR>',            {desc = 'Open git status'})
      vim.keymap.set('n', '<Leader>gS', '<Cmd>Gitsigns stage_buffer<CR>', {desc = 'Stage git buffer'})
      vim.keymap.set('n', '<Leader>gs', '<Cmd>Gitsigns stage_hunk<CR>',   {desc = 'Stage git hunk'})
      vim.keymap.set('n', ']g',         '<Cmd>Gitsigns next_hunk<CR>',    {desc = 'Next git hunk'})
      vim.keymap.set('n', '[g',         '<Cmd>Gitsigns prev_hunk<CR>',    {desc = 'Previous git hunk'})
    '';
  };
}
