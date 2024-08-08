{
  config,
  pkgs,
  ...
}: let
  dag = config.lib.dag;
in {
  home.stateVersion = "23.11";

  home.activation.report-changes = dag.entryAnywhere ''
    ${pkgs.nvd}/bin/nvd diff $oldGenPath $newGenPath
  '';

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["CommitMono"];})

    nvd
  ];
}
