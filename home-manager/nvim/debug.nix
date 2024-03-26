{ pkgs, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      nvim-dap
      nvim-dap-python
      nvim-dap-ui
    ];
    extraLuaConfig = /* lua */ ''
      vim.keymap.set('n', '<F9>',  '<Cmd>DapToggleBreakpoint<CR>', {desc = 'Toggle breakpoint'})
      vim.keymap.set('n', '<F10>', '<Cmd>DapContinue<CR>',         {desc = 'Debug continue'})
      vim.keymap.set('n', '<F11>', '<Cmd>DapStepInto<CR>',         {desc = 'Debug step into'})
      vim.keymap.set('n', '<F12>', '<Cmd>DapStepOver<CR>',         {desc = 'Debug step over'})
    '';
  };
}
