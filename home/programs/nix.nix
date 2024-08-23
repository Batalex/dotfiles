{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    nixd
    alejandra
    nix-prefetch-git
  ];
}
