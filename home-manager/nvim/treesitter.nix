{ pkgs, ... }:

let
  fromGitHub = import ../functions/fromGitHub.nix;
in

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      aerial-nvim
      nvim-treesitter.withAllGrammars
      nvim-treesitter-context
      nvim-treesitter-refactor
      nvim-treesitter-textobjects
      (fromGitHub {user = "calops";   repo = "hmts.nvim";})
      (fromGitHub {user = "drybalka"; repo = "tree-climber.nvim";})
      (fromGitHub {user = "m-demare"; repo = "hlargs.nvim";})
      (fromGitHub {user = "nfrid";    repo = "treesitter-utils";})
      (fromGitHub {user = "windwp";   repo = "nvim-ts-autotag";})
      # (fromGitHub {
      #   user = "lewis6991";
      #   repo = "tree-sitter-tcl";
      #   ref = "HEAD";
      #   buildScript = "make";
      # })
    ];
    extraLuaConfig = /* lua */ ''
      vim.cmd [[
      set foldmethod=expr
      set foldexpr=nvim_treesitter#foldexpr()
      set nofoldenable
      ]]
      -- Enable treesitter parsers, etc.
      require('nvim-treesitter.configs').setup({
        ensure_installed = {},
        sync_install = false,
        ignore_install = {},
        highlight = { enable = true },
        refactor = {
          navigation = {
            enable = true,
            keymaps = {
              goto_definition_lsp_fallback = 'gd',
              list_definitions = '<Leader>ld',
              list_definitions_toc = '<Leader>lt',
              goto_next_usage = ']u',
              goto_previous_usage = '[u'
            }
          },
          smart_rename = {
            enable = true,
            keymaps = {
              smart_rename = '<Leader>rt'
            }
          }
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = {
                query = '@function.outer',
                desc = 'Select around function'
              },
              ['if'] = {
                query = '@function.inner',
                desc  = 'Select inside function'
              },
              ['ac'] = {
                query = '@class.outer',
                desc  = 'Select around class'
              },
              ['ic'] = {
                query = '@class.inner',
                desc  = 'Select inside class'
              },
              ['ap'] = {
                query = '@class.inner',
                desc  = 'Select around parameter'
              },
              ['ip'] = {
                query = '@class.inner',
                desc  = 'Select inside parameter'
              }
            },
            selection_modes = {
              ['@parameter.outer'] = 'v',
              ['@function.outer'] = 'V',
              ['@class.outer'] = '<c-v>'
            },
            include_surrounding_whitespace = true
          },
          swap = {
            enable = true,
            swap_next = { ['<Leader>a'] = '@parameter.inner' },
            swap_previous = { ['<Leader>A'] = '@parameter.inner' }
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']f'] = {
                query = '@function.outer',
                desc  = 'Next function'
              },
              [']]'] = {
                query = '@class.outer',
                desc  = 'Next class'
              },
              [']p'] = {
                query = '@parameter.inner',
                desc  = 'Next parameter'
              },
            },
            goto_next_end = {
              [']F'] = {
                query = '@function.outer',
                desc  = 'Next function end'
              },
              [']['] = {
                query = '@class.outer',
                desc  = 'Next class end'
              },
              [']P'] = {
                query = '@parameter.inner',
                desc  = 'Next parameter end'
              },
            },
            goto_previous_start = {
              ['[f'] = {
                query = '@function.outer',
                desc  = 'Previous function'
              },
              ['[['] = {
                query = '@class.outer',
                desc  = 'Previous class'
              },
              ['[p'] = {
                query = '@parameter.inner',
                desc  = 'Previous parameter'
              },
            },
            goto_previous_end = {
              ['[F'] = {
                query = '@function.outer',
                desc  = 'Previous function end'
              },
              ['[]'] = {
                query = '@class.outer',
                desc  = 'Previous class end'
              },
              ['[P'] = {
                query = '@parameter.inner',
                desc  = 'Previous parameter end'
              },
            }
          },
          lsp_interop = {
            enable = true,
            border = 'none',
            floating_preview_opts = {},
            peek_definition_code = {
              ['<Leader>pf'] = {
                query = '@function.outer',
                desc  = 'Peek function definition'
              },
              ['<Leader>pc'] = {
                query = '@class.outer',
                desc  = 'Peek class definition'
              },
              ['<Leader>pp'] = {
                query = '@parameter.outer',
                desc  = 'Peek parameter definition'
              },
            }
          }
        }
      })
      -- Use treesitter to make a sticky header
      require('treesitter-context').setup({})
      -- Use treesitter to auto-close and rename HTML / XML / etc. tags
      require('nvim-ts-autotag').setup()
      -- Treesitter node overview
      require('aerial').setup()
      -- Code navigation
      vim.keymap.set('n', '<M-a>',   '<Cmd>AerialNavToggle<CR>',   {desc = 'Open overview pane'})
      vim.keymap.set('n', '<M-A>',   '<Cmd>AerialToggle left<CR>', {desc = 'Open overview pane'})
      -- Bracket movements
      local climb = require('tree-climber')
      vim.keymap.set('n', ']a', '<Cmd>AerialNext<CR>',                       {desc = 'Next class, method, etc.'})
      vim.keymap.set('n', '[a', '<Cmd>AerialPrev<CR>',                       {desc = 'Previous class, method, etc.'})
      vim.keymap.set('n', ']b', '<Cmd>bnext<CR>',                            {desc = 'Next buffer'})
      vim.keymap.set('n', '[b', '<Cmd>bprevious<CR>',                        {desc = 'Previous buffer'})
      vim.keymap.set('n', ']d', function() vim.diagnostic.goto_next({}) end, {desc = 'Next diagnostic'})
      vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev({}) end, {desc = 'Previous diagnostic'})
      vim.keymap.set('n', ']q', '<Cmd>cnext<CR>',                            {desc = 'Next quickfix item'})
      vim.keymap.set('n', '[q', '<Cmd>cprevious<CR>',                        {desc = 'Previous quickfix item'})
      vim.keymap.set('n', ']l', '<Cmd>lnext<CR>',                            {desc = 'Next local list item'})
      vim.keymap.set('n', '[l', '<Cmd>lprevious<CR>',                        {desc = 'Previous local list item'})
      vim.keymap.set('n', ']t', function() climb.goto_next() end,            {desc = 'Next treesitter node'})
      vim.keymap.set('n', '[t', function() climb.goto_prev() end,            {desc = 'Previous treesitter node'})
      vim.keymap.set('n', ']T', function() climb.goto_child() end,           {desc = 'Goto treesitter child'})
      vim.keymap.set('n', '[T', function() climb.goto_parent() end,          {desc = 'Goto treesitter parent'})
    '';
  };
}
