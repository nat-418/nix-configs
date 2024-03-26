{ pkgs, ... }:

let
  fromGitHub = import ../functions/fromGitHub.nix;
in

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      zen-mode-nvim
      (fromGitHub {user = "glippi";  repo = "badscratch.nvim";})
      (fromGitHub {user = "nat-418"; repo = "bufala.nvim";})
      (fromGitHub {user = "nat-418"; repo = "termitary.nvim";})
    ];
    extraLuaConfig = /* lua */ ''
      vim.o.number         = true
      vim.o.relativenumber = true
      vim.o.scrolloff      = 3
      vim.o.smartindent    = true
      vim.o.smarttab       = true
      vim.o.foldcolumn     = "1"
      vim.o.foldminlines   = 50
      vim.o.foldnestmax    = 0


      require('termitary').setup({}) -- Remote control terminals

      require('zen-mode').setup({
        window = {
          options = {
            number = false,
            relativenumber = false,
            signcolumn = "no",
            foldcolumn = "0"
          }
        }
      })

      vim.keymap.set('n', '<Leader>ta', '<Cmd>Termitary activate<CR>', {desc = 'Activate existing terminal buffer<CR>'})
      vim.keymap.set('n', '<Leader>tn', '<Cmd>Termitary new<CR>',      {desc = 'Open new terminal buffer<CR>'})
      vim.keymap.set('n', '<Leader>tp', '<Cmd>Termitary paste<CR>',    {desc = 'Paste text in terminal<CR>'})
      vim.keymap.set('n', '<Leader>tr', '<Cmd>Termitary repeat<CR>',   {desc = 'Repeat last sent terminal command<CR>'})
      vim.keymap.set('n', '<Leader>ts', '<Cmd>Termitary send<CR>',     {desc = 'Send text to terminal<CR>'})
      vim.keymap.set('n', '<Leader>tt', ':Termitary type ',            {desc = 'Type text in terminal'})

      -- Disable line numbering for terminal buffers
      local term = vim.api.nvim_create_augroup('TerminalStyle', { clear = true })
      vim.api.nvim_create_autocmd('TermOpen', {
        command = 'setlocal nonumber',
        group = term,
      })
      vim.api.nvim_create_autocmd('TermOpen', {
        command = 'setlocal norelativenumber',
        group = term,
      })

      vim.keymap.set('n', '<M-d>', '<Cmd>bdelete!<CR>',     {desc = 'Close current buffer'})
      vim.keymap.set('n', '<M-Tab>', '<Cmd>bnext<CR>',          {desc = 'Go to the next buffer'})
      vim.keymap.set('n', '<M-n>',   '<Cmd>bnext<CR>',          {desc = 'Go to the next buffer'})
      vim.keymap.set('n', '<M-p>',   '"+p',                     {desc = 'Paste from system clipboard'})
      vim.keymap.set('n', '<M-q>',   '<Cmd>quit<CR>',           {desc = 'Close current window'})
      vim.keymap.set('n', '<M-s>',   '<Cmd>botright split<CR>', {desc = 'Split window horizontally'})
      vim.keymap.set('n', '<M-v>',   '<Cmd>vsplit<CR>',         {desc = 'Split window vertically'})
      vim.keymap.set('n', '<M-w>',   '<Cmd>write<CR>',          {desc = 'Write current buffer'})
      vim.keymap.set('n', '<M-W>',   '<Cmd>write ++p<CR>',      {desc = 'Create needed directories and write buffer'})
      vim.keymap.set('n', '<M-y>',   '"+y',                     {desc = 'Copy to system clipboard'})
      vim.keymap.set('n', '<M-z>',   '<Cmd>ZenMode<CR>',        {desc = 'Toggle Zen mode'})

      vim.keymap.set('t', '<M-<Esc>>', '<Esc>',           {desc = 'Send Escape key to the terminal'})
      vim.keymap.set('t', '<M-p>',     '<C-\\><C-n>pi',   {desc = 'Paste from internal clipboard'})
      vim.keymap.set('t', '<M-P>',     '<C-\\><C-n>"+pi', {desc = 'Paste from system clipboard'})
      vim.keymap.set('t', '<Esc>',     '<C-\\><C-n>',     {desc = 'Escape from terminal mode'})

      vim.keymap.set('v', '<F1>', '"*y')
      vim.keymap.set('v', '<F2>', '"+y')
      vim.keymap.set('v', '<F3>', '"ay')
      vim.keymap.set('v', '<F4>', '"ap')

      vim.keymap.set('v', '<M-p>', '"+p', {desc = 'Paste from system clipboard'})
      vim.keymap.set('v', '<M-y>', '"+y', {desc = 'Copy to system clipboard'})

      vim.keymap.set('c', '<M-w>', '<C-r><C-w>', {desc = 'Insert word under cursor' })
      vim.keymap.set('c', '<M-p>', '<C-r><C-">', {desc = 'Insert last yanked' })

      vim.keymap.set('n', '-',                 function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end)
      vim.keymap.set('n', '<ScrollWheelUp>',   '<C-Y>')
      vim.keymap.set('n', '<ScrollWheelDown>', '<C-E>')
      vim.keymap.set('n', '<F1>',              '"*y')
      vim.keymap.set('n', '<F2>',              '"+y')
      vim.keymap.set('n', '<F3>',              '"ay')
      vim.keymap.set('n', '<F4>',              '"ap')
    '';
  };
}
