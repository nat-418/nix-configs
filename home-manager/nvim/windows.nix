{  ... }:

let
  fromGitHub = import ../functions/fromGitHub.nix;
in

{
  programs.neovim = {
    plugins = [
      (fromGitHub {user = "echasnovski"; repo = "mini.clue";})
      (fromGitHub {user = "echasnovski"; repo = "mini.files";})
      (fromGitHub {user = "nvim-tree";   repo = "nvim-web-devicons";})
      (fromGitHub {user = "echasnovski"; repo = "mini.statusline";})
    ];
   extraLuaConfig = /* lua */ ''
     -- Top and bottom UI
     require('mini.statusline').setup({})
     vim.o.laststatus = 2
     vim.o.showmode   = false -- Not needed with statusline

     -- Better file browsing
     require('mini.files').setup({})

     -- Show available keymaps
     local miniclue = require('mini.clue')
     miniclue.setup({
       triggers = {
         -- Leader triggers
         { mode = 'n', keys = '<Leader>' },
         { mode = 'x', keys = '<Leader>' },

         -- Built-in completion
         { mode = 'i', keys = '<C-x>' },

         -- `g` key
         { mode = 'n', keys = 'g' },
         { mode = 'x', keys = 'g' },

         -- Marks
         { mode = 'n', keys = "'" },
         { mode = 'n', keys = '`' },
         { mode = 'x', keys = "'" },
         { mode = 'x', keys = '`' },

         -- Registers
         { mode = 'n', keys = '"' },
         { mode = 'x', keys = '"' },
         { mode = 'i', keys = '<C-r>' },
         { mode = 'c', keys = '<C-r>' },

         -- Window commands
         { mode = 'n', keys = '<C-w>' },

         -- `z` key
         { mode = 'n', keys = 'z' },
         { mode = 'x', keys = 'z' },
       },

       clues = {
         -- Enhance this by adding descriptions for <Leader> mapping groups
         miniclue.gen_clues.builtin_completion(),
         miniclue.gen_clues.g(),
         miniclue.gen_clues.marks(),
         miniclue.gen_clues.registers(),
         miniclue.gen_clues.windows(),
         miniclue.gen_clues.z(),
       },
     })

     -- Window movement
     vim.keymap.set('n', '<M-h>', '<C-w>h',        {desc = 'Move left a window'})
     vim.keymap.set('n', '<M-j>', '<C-w>j',        {desc = 'Move down a window'})
     vim.keymap.set('n', '<M-k>', '<C-w>k',        {desc = 'Move up a window'})
     vim.keymap.set('n', '<M-l>', '<C-w>l',        {desc = 'Move right a window'})
     vim.keymap.set('n', '<M-Q>', '<Cmd>qall<CR>', {desc = 'Quit everything'})
   '';
  };
}
