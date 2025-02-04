{pkgs, ...}: {
  home.file.".config/ghostty/config".source = ./ghostty_config;

  home.packages = with pkgs; [
    mpv
  ];
}
