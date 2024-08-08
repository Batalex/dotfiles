{
  config,
  pkgs,
  ...
}: {
  home.sessionVariables = {
    EDITOR = "hx";
  };

  programs.helix = {
    enable = true;
    settings = pkgs.lib.importTOML ./config.toml;
    languages = pkgs.lib.importTOML ./languages.toml;
    defaultEditor = true;
  };
}
