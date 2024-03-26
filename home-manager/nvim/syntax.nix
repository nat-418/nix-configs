{ pkgs, ... }:

let
  fromGitHub = import ../functions/fromGitHub.nix;
in

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      plantuml-syntax
      vim-mustache-handlebars
      vim-nix
      (fromGitHub {user = "NoahTheDuke";   repo = "vim-just";})
    ];
    extraLuaConfig = /* lua */ ''
      -- fix terraform and hcl comment string
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
        callback = function(ev)
          vim.bo[ev.buf].commentstring = "# %s"
        end,
        pattern = { "terraform", "hcl" },
      })
    '';
  };
}
