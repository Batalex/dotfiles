{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./zsh.nix
    ./starship
    ./zellij
  ];
}
