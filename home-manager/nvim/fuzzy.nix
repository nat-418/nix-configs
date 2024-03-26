{ pkgs, ... }:

let
  fromGitHub = import ../functions/fromGitHub.nix;
in

{
  home.packages = with pkgs; [
    fzf
  ];
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      fzf-lua
      (fromGitHub {user = "aaronhallaert"; repo = "advanced-git-search.nvim";})
      (fromGitHub {user = "AckslD";        repo = "muren.nvim";})
      #(rawGitHub {user = "linrongbin16";  repo = "fzfx.nvim";})
    ];
    extraLuaConfig = /* lua */ ''
      require('advanced_git_search.fzf').setup({})
      vim.keymap.set('n', '<Leader>fA', '<Cmd>FzfLua lsp_code_actions<CR>',                            {desc = 'Fuzzy-find actions'})
      vim.keymap.set('n', '<Leader>fC', '<Cmd>FzfLua live_grep cwd=~/Code<CR>',                        {desc = 'Fuzzy-find ~/Code'})
      vim.keymap.set('n', '<Leader>fd', '<Cmd>FzfLua diagnostics_document<CR>',                        {desc = 'Fuzzy-find diagnostics in buffer'})
      vim.keymap.set('n', '<Leader>fD', '<Cmd>FzfLua diagnostics_workspace<CR>',                       {desc = 'Fuzzy-find diagnostics in workspace'})
      vim.keymap.set('n', '<Leader>fF', '<Cmd>FzfLua live_grep<CR>',                                   {desc = 'Fuzzy-grep files'})
      vim.keymap.set('n', '<Leader>fH', '<Cmd>FzfLua files cmd="bfs -mindepth 1 -nohidden" cwd=~<CR>', {desc = 'Fuzzy-find $HOME files'})
      vim.keymap.set('n', '<Leader>fL', '<Cmd>FzfLua lines<CR>',                                       {desc = 'Fuzzy-find lines in all buffers'})
      vim.keymap.set('n', '<Leader>fM', '<Cmd>FzfLua man_pages<CR>',                                   {desc = 'Fuzzy-find manuals'})
      vim.keymap.set('n', '<Leader>fN', '<Cmd>FzfLua live_grep cwd=~/.config/nvim/<CR>',               {desc = 'Fuzzy-grep Neovim configuration files'})
      vim.keymap.set('n', '<Leader>fa', '<Cmd>FzfLua args<CR>',                                        {desc = 'Fuzzy-find argument list'})
      vim.keymap.set('n', '<Leader>fb', '<Cmd>FzfLua buffers<CR>',                                     {desc = 'Fuzzy-find buffers'})
      vim.keymap.set('n', '<Leader>fc', '<Cmd>FzfLua commands<CR>',                                    {desc = 'Fuzzy-find commands'})
      vim.keymap.set('n', '<Leader>ff', '<Cmd>FzfLua files<CR>',                                       {desc = 'Fuzzy-find files'})
      vim.keymap.set('n', '<Leader>fh', '<Cmd>FzfLua help_tags<CR>',                                   {desc = 'Fuzzy-find help'})
      vim.keymap.set('n', '<Leader>fj', '<Cmd>FzfLua jumps<CR>',                                       {desc = 'Fuzzy-find jumps'})
      vim.keymap.set('n', '<Leader>fk', '<Cmd>FzfLua keymaps<CR>',                                     {desc = 'Fuzzy-find keymaps'})
      vim.keymap.set('n', '<Leader>fl', '<Cmd>FzfLua blines<CR>',                                      {desc = 'Fuzzy-find lines in current buffer'})
      vim.keymap.set('n', '<Leader>fm', '<Cmd>FzfLua marks<CR>',                                       {desc = 'Fuzzy-find marks'})
      vim.keymap.set('n', '<Leader>fn', '<Cmd>FzfLua files cwd=~/.config/nvim/<CR>',                   {desc = 'Fuzzy-find Neovim configuration files'})
      vim.keymap.set('n', '<Leader>fo', '<Cmd>FzfLua oldfiles<CR>',                                    {desc = 'Fuzzy-find oldfiles'})
      vim.keymap.set('n', '<Leader>fq', '<Cmd>FzfLua quickfix<CR>',                                    {desc = 'Fuzzy-find quickfix'})
      vim.keymap.set('n', '<Leader>fQ', '<Cmd>FzfLua quickfix_stack<CR>',                              {desc = 'Fuzzy-find quickfix stack'})
      vim.keymap.set('n', '<Leader>fr', '<Cmd>FzfLua resume<CR>',                                      {desc = 'Resume last search'})
      vim.keymap.set('n', '<Leader>ft', '<Cmd>FzfLua tabs<CR>',                                        {desc = 'Fuzzy-find tabs'})
      vim.keymap.set('n', '<Leader>fs', '<Cmd>FzfLua lsp_document_symbols<CR>',                        {desc = 'Fuzzy-find symbols'})
      vim.keymap.set('n', '<Leader>/',  function() return vim.cmd.nohlsearch() end,                    {desc = 'Clear search highlighting'})
      vim.keymap.set('n', '<Leader>rm', function() return vim.cmd.MurenToggle() end,                   {desc = 'Search and replace text'})

      vim.keymap.set('n', '<Leader>sb', function()
        local regex = vim.fn.input({ prompt = 'Buffer-local regex: ' })
        return vim.cmd.lgrep(regex .. ' %')
      end, {desc = 'Grep in current buffer'})
      
      vim.keymap.set('n', '<Leader>sd', function()
        local dirname = vim.fn.input({ prompt = 'Directory path: ' })
        local regex   = vim.fn.input({ prompt = 'Directory-recursive regex: ' })
        return vim.cmd.lgrep(regex .. ' ' .. dirname)
      end, {desc = 'Grep in current directory'})
    '';
  };
}
