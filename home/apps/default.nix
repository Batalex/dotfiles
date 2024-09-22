{
  config,
  pkgs,
  ...
}: {
  programs.alacritty.enable = true;

  home.packages = with pkgs; [
    obsidian
  ];
}
