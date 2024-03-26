# Firefox web browser, extensions, search, and bookmarks configuration.
{ pkgs, ... }:

let
  # nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
  #   inherit pkgs;
  # };
  templateURL = str: [{ template = str + "{searchTerms}"; }];
  personalBookmarks = import ./personal-bookmarks.nix {};
  workBookmarks = import ./work-bookmarks.nix {};
in

{
  programs.firefox = {
    enable = true;
    profiles.default = {
      bookmarks = [
        {
          name = "Nix";
          bookmarks = [
            {
              name = "Nix User Repositories";
              url = "https://nur.nix-community.org/";
            }
            {
              name = "NixOS Homepage";
              url = "https://nixos.org/";
            }
            {
              name = "NixOS Wiki";
              url = "https://nixos.wiki/";
            }
            {
              name = "NixOS Discourse";
              url = "https://discourse.nixos.org/";
            }
          ];
        }
        {
          name = "Home Manager";
          bookmarks = [
            {
              name = "Home Manager Option Search";
              url = "https://mipmip.github.io/home-manager-option-search/";
            }
            {
              name = "Home Manager Manual";
              url = "https://nix-community.github.io/home-manager/";
            }
          ];
        }
      ] ++ personalBookmarks ++ workBookmarks;
      # extensions = with nur.repos.rycee.firefox-addons; [
      #   boring-rss
      #   libredirect
      #   privacy-badger
      #   ublock-origin
      #   wappalyzer
      # ];
      search = {
        default = "DuckDuckGo";
        engines = {
          "Bing".metaData.hidden = true;
          "DuckDuckGo".metaData.alias = "!ddg";
          "Google".metaData.alias = "!g";
          "Home Manager Options" = {
            definedAliases = [ "!hm" ];
            urls = [{
              template = "https://home-manager-options.extranix.com/";
              params = [
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
          };
          "Nix Packages" = {
            definedAliases = [ "!np" ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
          };
          "NixOS Options" = {
            definedAliases = [ "!no" ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            urls = [{
              params = [
                { name = "type"; value = "options"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
              template = "https://search.nixos.org/options";
            }];
          };
          "NixOS Wiki" = {
            definedAliases = [ "!nw" ];
            iconUpdateURL = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000;
            urls = (templateURL "https://nixos.wiki/index.php?search=");
          };
          "Qwant" = {
            definedAliases = [ "!q" ];
            iconUpdateURL = "https://www.qwant.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            urls = (templateURL "https://www.qwant.com/?q=");
          };
          "Terraform Modules" = {
            definedAliases = [ "!tm" ];
            icon = "https://www.terraform.io/favicon.ico";
            urls = (templateURL "https://registry.terraform.io/search/modules?q=");
          };
          "Terraform Providers" = {
            definedAliases = [ "!tp" ];
            icon = "https://www.terraform.io/favicon.ico";
            urls = (templateURL "https://registry.terraform.io/search/providers?q=");
          };
          "Wikipedia (en)".metaData.alias = "!w";
        };
        force = true;
      };
    };
  };
}
