{
  config,
  pkgs,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      font.normal.family = "CommitMono Nerd Font";
      # Catppuccin macchiato
      colors.primary = {
        background = "#24273A";
        foreground = "#CAD3F5";
        dim_foreground = "#CAD3F5";
        bright_foreground = "#CAD3F5";
      };
      colors.cursor = {
        text = "#24273A";
        cursor = "#F4DBD6";
      };
      colors.vi_mode_cursor = {
        text = "#24273A";
        cursor = "#B7BDF8";
      };
      colors.search.matches = {
        foreground = "#24273A";
        background = "#A5ADCB";
      };
      colors.search.focused_match = {
        foreground = "#24273A";
        background = "#A6DA95";
      };
      colors.footer_bar = {
        foreground = "#24273A";
        background = "#A5ADCB";
      };
      colors.hints.start = {
        foreground = "#24273A";
        background = "#EED49F";
      };
      colors.hints.end = {
        foreground = "#24273A";
        background = "#A5ADCB";
      };
      colors.selection = {
        text = "#24273A";
        background = "#F4DBD6";
      };
      colors.normal = {
        black = "#494D64";
        red = "#ED8796";
        green = "#A6DA95";
        yellow = "#EED49F";
        blue = "#8AADF4";
        magenta = "#F5BDE6";
        cyan = "#8BD5CA";
        white = "#B8C0E0";
      };
      colors.bright = {
        black = "#5B6078";
        red = "#ED8796";
        green = "#A6DA95";
        yellow = "#EED49F";
        blue = "#8AADF4";
        magenta = "#F5BDE6";
        cyan = "#8BD5CA";
        white = "#A5ADCB";
      };
      colors.dim = {
        black = "#494D64";
        red = "#ED8796";
        green = "#A6DA95";
        yellow = "#EED49F";
        blue = "#8AADF4";
        magenta = "#F5BDE6";
        cyan = "#8BD5CA";
        white = "#B8C0E0";
      };
      colors.indexed_colors = [
        {
          index = 16;
          color = "#F5A97F";
        }
        {
          index = 17;
          color = "#F4DBD6";
        }
      ];
    };
  };

  # home.packages = with pkgs; [
  # ];
}
