{
  config,
  pkgs,
  ...
}: {
  home.file = {
    ".config/zellij/config.kdl".source = ./config.kdl;
  };

  programs.zellij = {
    enable = true;
    enableZshIntegration = false;
  };
  programs.zsh.shellAliases = {
    zj = "zellij";
  };
}
