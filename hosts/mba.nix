{
  config,
  pkgs,
  pkgs-stable,
  lib,
  ...
}: {
  home.username = "abatisse";
  home.homeDirectory = "/Users/abatisse";

  imports = [../home];

  home.packages = [
    pkgs.typst
    # mba-pkgs-stable.calibre
  ];
}
