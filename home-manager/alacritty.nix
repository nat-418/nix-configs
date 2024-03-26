# Alacritty is a very fast terminal emulator.
{ ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        # Gruvbox Material colors
        primary = {
          background = "#282828";  
          foreground = "#d4be98";  
          dim_foreground = "#ecdc8a";
          bright_foreground = "#0f0d0e";
        };
        normal = {
          black = "#3c3836";    
          blue = "#7daea3";    
          cyan = "#89b482";    
          green = "#a9b665";    
          magenta = "#d3869b";    
          red = "#ea6962";    
          white = "#d4be98";    
          yellow = "#d8a657";    
        };
        selection = {
          background = "#44c9f0";
        };
        dim = {
          black = "#1c191a";
          blue = "#0e91b7";
          cyan = "#93d4e7";
          green = "#098749";
          magenta = "#624a87";
          red = "#c7102a";
          white = "#c1c1c1";
        };
        bright = {
          black = "#3c3836";    
          blue = "#7daea3";    
          cyan = "#89b482";    
          green = "#a9b665";    
          magenta = "#d3869b";    
          red = "#ea6962";    
          white = "#d4be98";    
          yellow = "#d8a657";    
        };
      };
      font = {
        normal = {
          family = "BlexMono Nerd Font Mono";
          style = "Medium";
        };
        bold = {
          family = "BlexMono Nerd Font Mono";
          style = "Bold";
        };
        italic = {
          family = "BlexMono Nerd Font Mono";
          style = "Italic";
        };
        bold_italic = {
          family = "BlexMono Nerd Font Mono";
          style = "Bold Italic";
        };
        size = 8;
      };
      shell = {
        program = "fish";
        args = [];
      };
      window = {
        blur = true;
        opacity = 0.98;
        padding = { x = 8; y = 8; };
      };
    };
  };
}

