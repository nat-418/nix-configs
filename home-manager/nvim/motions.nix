{ ... }:

let
  fromGitHub = import ../functions/fromGitHub.nix;
in

{
  programs.neovim = {
    plugins = [
      (fromGitHub {user = "echasnovski"; repo = "mini.comment";})
      (fromGitHub {user = "echasnovski"; repo = "mini.jump";})
      (fromGitHub {user = "echasnovski"; repo = "mini.jump2d";})
      (fromGitHub {user = "echasnovski"; repo = "mini.surround";})
      (fromGitHub {user = "nat-418";     repo = "boole.nvim";})
      (fromGitHub {user = "sam4llis";    repo = "nvim-lua-gf";})
    ];
    extraLuaConfig = /* lua */ ''
      -- Allow incermenting and decrementing words, not just numbers:
      require('boole').setup({
        mappings = {
          increment = '<C-a>',
          decrement = '<C-x>'
        }
      })
      require('mini.comment').setup({})  -- gcc to comment lines, etc
      require('mini.surround').setup({}) -- saiw' to add quotes, etc.
      require('mini.jump').setup({})     -- Improve f & t, jump anywhere
      require('mini.jump2d').setup({
        view = {
          dim = true,
          n_steps_ahead = 1,
        },
        mappings = {
          start_jumping = ""
        }
      })
      vim.keymap.set('v', '<CR>', function()
        MiniJump2d.start(MiniJump2d.builtin_opts.single_character)
      end, {desc = 'Jump to any visible location'})

      -- Jump anywhere
      vim.keymap.set('n', '<CR>', function()
        MiniJump2d.start(MiniJump2d.builtin_opts.single_character)
      end, {desc = 'Jump to any visible location'})
    '';
  };
}
