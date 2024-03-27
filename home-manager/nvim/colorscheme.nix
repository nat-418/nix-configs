{ pkgs, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      gruvbox-material
      tint-nvim
    ];
    extraLuaConfig = /* lua */ ''
      vim.o.termguicolors  = true
      vim.cmd('colorscheme gruvbox-material')
      vim.g.gruvbox_material_background = 'hard'
      require('tint').setup({
        highlight_ignore_patterns = {
          'MiniJump'
        },
      })

     if vim.g.neovide then
       vim.g.neovide_transparency = 0.95
     else
        vim.cmd('highlight Normal      ctermbg=NONE guibg=NONE')
        vim.cmd('highlight NormalNC    ctermbg=NONE guibg=NONE')
        vim.cmd('highlight EndOfBuffer ctermbg=NONE guibg=NONE')
        vim.g.transparency = 0.95
     end

      vim.cmd('highlight IncSearch gui=bold guibg=Brown guifg=Wheat')
      vim.cmd('highlight Search    gui=bold guibg=Teal  guifg=Wheat')

      vim.cmd('highlight MiniJump            gui=bold guifg=Goldenrod')
      vim.cmd('highlight MiniJump2dDim       gui=NONE guifg=SlateGray')
      vim.cmd('highlight MiniJump2dSpot      gui=bold guifg=Goldenrod')
      vim.cmd('highlight MiniJump2dSpotAhead gui=bold guifg=Goldenrod')
    '';
  };
}
