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

  programs.btop.enable = true;

  programs.bat.enable = true;

  home.packages = with pkgs; [
    yq
    delta
    tldr
  ];
}
