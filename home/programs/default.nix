{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./dprint
    ./git.nix
    ./helix
    ./nix.nix
    ./python.nix
    ./vale
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.ripgrep.enable = true;

  programs.fzf.enable = true;

  programs.bottom.enable = true;

  programs.bat = {
    enable = true;
    config = {
      theme = "catppuccin";
    };
    themes = {
      catppuccin = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "d3feec47b16a8e99eabb34cdfbaa115541d374fc";
          sha256 = "1g73x0p8pbzb8d1g1x1fwhwf05sj3nzhbhb65811752p5178fh5k";
        };
        file = "themes/Catppuccin Macchiato.tmTheme";
      };
    };
  };

  home.packages = with pkgs; [
    yq
    tldr
  ];
}
