{pkgs, ...}: {
  imports = [
    ./dev.nix
    ./dprint
    ./git.nix
    ./helix
    ./nix.nix
    ./vale
  ];

  programs.bottom.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf.enable = true;

  programs.ripgrep.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd cd"
    ];
  };

  home.packages = with pkgs; [
    age
    tldr
    rip2
  ];
}
