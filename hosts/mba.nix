{
  pkgs,
  craft-ls,
  ...
}: {
  home.username = "abatisse";
  home.homeDirectory = "/Users/abatisse";

  imports = [../home];

  home.packages = with pkgs; [
    typst
    yq
    craft-ls.packages.aarch64-darwin.default
  ];
}
