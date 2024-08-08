{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    vale
    vale-ls
  ];
  home.file.".config/vale/.vale.ini".source = ./vale.ini;
  home.sessionVariables.VALE_CONFIG_PATH = "~/.config/vale/.vale.ini";
}
