{ ... }:

let
  fromGitHub = import ../functions/fromGitHub.nix;
in

{
  programs.neovim = {
    plugins = [
      (fromGitHub {user = "echasnovski"; repo = "mini.completion";})
    ];
    extraLuaConfig = /* lua */ ''
      -- Native completion
      vim.keymap.set('i', '<C-f>', '<C-x><C-f>', { desc = 'File path completion' })
      vim.keymap.set('i', '<C-l>', '<C-x><C-l>', { desc = 'Buffer line completion' })
      vim.keymap.set('i', '<C-n>', '<C-x><C-n>', { desc = 'Buffer word completion' })
      vim.keymap.set('i', '<C-o>', '<C-x><C-o>', { desc = 'Omnifunc completion' })
      vim.keymap.set('i', '<C-p>', '<C-x><C-p>', { desc = 'Buffer word completion' })

      -- Two-stage autocomplete with LSP
      require('mini.completion').setup({})

      -- Use tab and Shift-tab to move through completion menus:
      local function cmpMap(lhs, rhs)
        return vim.api.nvim_set_keymap('i', lhs, rhs, { noremap = true, expr = true })
      end

      cmpMap('<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
      cmpMap('<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

      -- Make <CR> behave normally
      local function replaceTC(lhs)
        return vim.api.nvim_replace_termcodes(lhs, true, true, true)
      end
      local keys = {
        ['cr']        = replaceTC('<CR>'),
        ['ctrl-y']    = replaceTC('<C-y>'),
        ['ctrl-y_cr'] = replaceTC('<C-y><CR>'),
      }

      _G.cr_action = function()
        if vim.fn.pumvisible() ~= 0 then
          -- If popup is visible, confirm selected item or add new line otherwise
          local item_selected = vim.fn.complete_info()['selected'] ~= -1
          return item_selected and keys['ctrl-y'] or keys['ctrl-y_cr']
        else
          -- If popup is not visible, use plain `<CR>`. You might want to customize
          -- according to other plugins. For example, to use 'mini.pairs', replace
          -- next line with `return require('mini.pairs').cr()`
          return keys['cr']
        end
      end

      cmpMap('<CR>', 'v:lua._G.cr_action()')
    '';
  };
}
