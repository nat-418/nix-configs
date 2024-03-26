{ ... }:

let
  fromGitHub = import ../functions/fromGitHub.nix;
in

{
  home.file."Documents/Wiki/.keep" = {
    text = "keep";
  };
  programs.neovim = {
    plugins = [
      (fromGitHub {user = "lervag"; repo = "wiki-ft.vim";})
      (fromGitHub {user = "lervag"; repo = "wiki.vim"; ref = "refs/tags/v0.8";})
    ];
    extraLuaConfig = ''
      vim.g.wiki_root = '~/Documents/Wiki'
      vim.g.wiki_select_method = 'fzf'
      vim.g.wiki_fzf_pages_opts =
          '--reverse ' ..
          '--preview="bat --color=always --theme=gruvbox-dark --style=snip {1}" ' ..
          '--preview-window=bottom '
      vim.g.wiki_fzf_tags_opts =
          '--reverse ' ..
          '--preview="bat --color=always --theme=gruvbox-dark --style=snip {2}" ' ..
          '--preview-window=bottom '
      vim.g.wiki_mappings_use_defaults = 'none'
    
      local lmap = function(lhs, rhs, des)
        return vim.keymap.set('n', '<Leader>' .. lhs, rhs, {desc = des})
      end
      -- Wiki
      lmap('w<BS>', '<Plug>(wiki-link-return)',          'Open last wiki page')
      lmap('w<CR>', '<Plug>(wiki-link-follow)',          'Create and/or follow link')
      lmap('wgb',   '<Plug>(wiki-graph-find-backlinks)', 'Show backlinks to page')
      lmap('wgc',   '<Plug>(wiki-graph-check-links)',    'Check for broken links')
      lmap('wgi',   '<Plug>(wiki-graph-in)',             'Show links out from page')
      lmap('wgo',   '<Plug>(wiki-graph-out)',            'Show links to the page')
      lmap('wgr',   '<Plug>(wiki-graph-related)',        'Show related pages')
      lmap('wi',    '<Plug>(wiki-journal)',              'Open today\'s journal')
      lmap('ww',    '<Plug>(wiki-index)',                'Open Wiki root index')
      lmap('wj',    '<Plug>(wiki-link-next)',            'Jump to next link')
      lmap('wk',    '<Plug>(wiki-link-prev)',            'Jump to previous link')
      lmap('wo',    ':!inline --theme=dark % &',         'Open buffer in renderer')
      lmap('wp',    '<Plug>(wiki-pages)',                'Find a wiki page by name')
      lmap('wt',    '<Plug>(wiki-tags)',                 'Find a wiki page by tag')
    '';
  };
}
