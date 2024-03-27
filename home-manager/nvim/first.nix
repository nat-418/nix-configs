{ ... }:

let
  fromGitHub = import ../functions/fromGitHub.nix;
in

{
  programs.neovim = {
    plugins = [
      # (fromGitHub {user = "AckslD";        repo = "muren.nvim";})
      (fromGitHub {user = "MunifTanjim";   repo = "nui.nvim";})
      # (fromGitHub {user = "NFrid";         repo = "markdown-togglecheck";})
      # (fromGitHub {user = "chrisgrieser";  repo = "nvim-alt-substitute";})
      (fromGitHub {user = "echasnovski";   repo = "mini.animate";})
      (fromGitHub {user = "echasnovski";   repo = "mini.indentscope";})
      # (fromGitHub {user = "echasnovski";   repo = "mini.sessions";})
      (fromGitHub {user = "nat-418";       repo = "scamp.nvim";})
      # (fromGitHub {user = "tomiis4";       repo = "hypersonic.nvim";})
      # (fromGitHub {user = "arnarg";        repo = "todotxt.nvim";})
      (fromGitHub {user = "echasnovski";   repo = "mini.pick";})
    ];
    extraLuaConfig = /* lua */ ''
      require('scamp').setup()
      vim.g.mapleader      = ' '
      vim.g.maplocalleader = ','
      vim.o.wrap           = false
      vim.o.shell          = 'fish'

      local config = vim.fn.expand('$HOME/.config/home-manager/nvim/default.nix')

      vim.keymap.set('n', '<Leader>I',  function() vim.cmd.source(config) end, {desc = 'Reload init.lua'})
      vim.keymap.set('n', '<Leader>i',  function() vim.cmd.edit(config) end,   {desc = 'Edit init.lua'})

      -- Disable buggy builtin (legacy) plugins
      vim.g.loaded_netrwPlugin = 1
      vim.g.loaded_netrw       = 1

      if vim.g.neovide then
        vim.o.guifont = "BlexMono Nerd Font Mono Regular:h12"
        vim.g.neovide_scale_factor = 1.0
      else
        require('mini.animate').setup({})     -- Smooth scrolling, etc.
      end

      require('mini.indentscope').setup({}) -- Show indent level
      -- require('mini.sessions').setup({})    -- Session management
      -- require('scamp').setup({})            -- Edit files over SCP
      -- require('muren').setup({})            -- multiple search / replace
      -- require('todotxt-nvim').setup({       -- todo.txt integration
      --   todo_file = "$HOME/todo.txt"
      -- })

      require('mini.pick').setup({})
    '';
  };
}
