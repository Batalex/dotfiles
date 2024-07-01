{
  config,
  pkgs,
  mba-pkgs-stable,
  lib,
  ...
}: {
  home.username = "abatisse";
  home.homeDirectory = "/Users/abatisse";

  programs.alacritty.enable = true;

  home.packages = [
    # mba-pkgs-stable.calibre
  ];
}
