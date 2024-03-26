# Rio is an interesting newer terminal emulator,
# similar to Alacritty but with tabs, splits, etc.
{ ... }:

{
  programs.rio = {
    enable = true;
    settings = {
      colors = {
        # Gruvbox Material colors
        ## Regular colors
        background = "#282828";  
        black = "#3c3836";    
        blue = "#7daea3";    
        cursor = "#d4be98";      
        cyan = "#89b482";    
        foreground = "#d4be98";  
        green = "#a9b665";    
        magenta = "#d3869b";    
        red = "#ea6962";    
        white = "#d4be98";    
        yellow = "#d8a657";    

        ## UI colors
        selection-background = "#44c9f0";
        selection-foreground = "#0f0d0e";
        tabs = "#624a87";
        tabs-active = "#d3869b";

        ## Dim colors
        dim-black = "#1c191a";
        dim-blue = "#0e91b7";
        dim-cyan = "#93d4e7";
        dim-foreground = "#ecdc8a";
        dim-green = "#098749";
        dim-magenta = "#624a87";
        dim-red = "#c7102a";
        dim-white = "#c1c1c1";

        ## Light colors
        light-black = "#3c3836";    
        light-blue = "#7daea3";    
        light-cyan = "#89b482";    
        light-green = "#a9b665";    
        light-magenta = "#d3869b";    
        light-red = "#ea6962";    
        light-white = "#d4be98";    
        light-yellow = "#d8a657";    
      };
      fonts = {
        family = "BlexMono Nerd Font";
        size = 14;
      };
      navigation = {
        mode = "CollapsedTab";
        clickable = true;
      };
      padding-x = 4;
      shell = {
        program = "fish";
        args = [];
      };
      window = {
        foreground-opacity = 1.0;
        background-opacity = 0.95;
        blur = true;
      };
    };
  };
}
