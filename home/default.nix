{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./common.nix
    ./shell
    ./programs
    ./apps
  ];
}
