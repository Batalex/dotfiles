{
  config,
  pkgs,
  ...
}: let
  commitmono-typeface = pkgs.callPackage ./packages/fonts/commitmono/default.nix {};
  dag = config.lib.dag;
in {
  home.stateVersion = "23.11";

  home.activation.report-changes = dag.entryAnywhere ''
    ${pkgs.nvd}/bin/nvd diff $oldGenPath $newGenPath
  '';

  programs.home-manager.enable = true;
  news.display = "silent";

  home.packages = with pkgs; [
    # TODO: Fix access path for alacritty?
    commitmono-typeface
    nerd-fonts.commit-mono

    nvd
  ];
}
