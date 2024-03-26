{ pkgs, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      undotree
    ];
    extraLuaConfig = /* lua */ ''
      vim.o.undofile = true

      vim.keymap.set('n', '<Leader>u', function()
        vim.cmd('UndotreeToggle')
        vim.cmd('UndotreeFocus')
      end, {desc = 'Toggle undo tree window'})
    '';
  };
}
