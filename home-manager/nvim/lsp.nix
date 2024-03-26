{ pkgs, ... }:

let
  fromGitHub = import ../functions/fromGitHub.nix;
in

{
  home.packages = with pkgs; [
    cargo 
    dune_3
    gcc
    ghc
    go
    gopls
    gotools
    haskell-language-server
    lua-language-server
    nil
    nodePackages.typescript-language-server
    ocaml
    ocamlPackages.ocaml-lsp
    ocamlPackages.utop
    ocamlformat
    pylyzer
    python3Packages.debugpy
    python3Packages.jedi-language-server
    python3Packages.ruff-lsp
    racket
    ruff
    rust-analyzer
    rustc
    terraform-ls
    zig
    zls
  ];
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      (fromGitHub {user = "VidocqH"; repo = "lsp-lens.nvim";})
      nvim-lspconfig
      neodev-nvim
    ];
    extraLuaConfig = /* lua */ ''
      -- Must be before lspconfig
      require("neodev").setup({})

      -- then setup your lsp server as usual
      local lspc = require('lspconfig')

      -- example to setup lua_ls and enable call snippets
      lspc.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
            completion = {
              callSnippet = "Replace"
            }
          }
        }
      })

      lspc.gopls.setup({})                -- Go
      lspc.hls.setup({})                  -- Haskell
      lspc.nil_ls.setup({})               -- Nix
      lspc.ocamllsp.setup({})             -- OCaml
      lspc.jedi_language_server.setup({}) -- Python
      lspc.ruff_lsp.setup({})             -- ...also Python
      lspc.racket_langserver.setup({})    -- Racket
      lspc.tsserver.setup({})             -- JavaScript / TypeScript
      lspc.sqlls.setup({})                -- SQL
      lspc.terraformls.setup({})          -- Terraform
      lspc.rust_analyzer.setup({})        -- Rust
      lspc.zls.setup({})                  -- Zig

      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      --vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      --vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          -- vim.keymap.set('n', '<space>wl', function()
          --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          -- end, opts)
          -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          -- vim.keymap.set('n', '<space>rl', vim.lsp.buf.rename, opts)
          -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          -- vim.keymap.set('n', '<space>f', function()
          --   vim.lsp.buf.format { async = true }
          -- end, opts)
        end,
      })
      vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
      vim.o.updatetime = 250
      vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
      -- Misc.
      vim.keymap.set('n', '<M-do>', function() vim.diagnostic.open_float() end, {desc = 'Open diagnostics'})
      vim.keymap.set('n', '<M-dq>', function() vim.diagnostic.setloclist() end, {desc = 'Diagnostics → loclist'})
      vim.keymap.set('n', '<M-K>',  function() vim.lsp.buf.hover() end,         {desc = 'Show language help'})
    '';
  };
}
