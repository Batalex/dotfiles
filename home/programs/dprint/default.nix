{
  config,
  pkgs,
  ...
}: {
  home.file = {
    "dprint.json".source = ./dprint.json;
  };

  home.packages = with pkgs; [
    dprint
  ];
}
