{
  config,
  pkgs,
  ...
}: {
  home.file = {
    ".config/zellij/config.kdl".source = ./config.kdl;
    ".config/zellij/themes/catpuccin.kdl".source = ./themes/catppuccin.kdl;
  };

  programs.zellij.enable = true;
  programs.zsh.shellAliases = {
    zj = "zellij";
  };
}
