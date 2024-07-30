{
  config,
  pkgs,
  pkgs-stable,
  lib,
  ...
}: let
  nixGLWrap = pkg:
    pkgs.runCommand "${pkg.name}-nixgl-wrapper" {} ''
      mkdir $out
      ln -s ${pkg}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${pkg}/bin/*; do
       wrapped_bin=$out/bin/$(basename $bin)
       echo "exec ${lib.getExe pkgs.nixgl.nixGLIntel} $bin \$@" > $wrapped_bin
       chmod +x $wrapped_bin
      done
    '';
in {
  home.username = "alex";
  home.homeDirectory = "/home/alex";
  xdg.enable = true;
  xdg.mime.enable = true;
  targets.genericLinux.enable = true;

  programs.alacritty.package = nixGLWrap pkgs.alacritty;

  programs.zsh = {
    shellAliases = {
      jam = "juju add-model";
      jdm = "juju destroy-model --force --no-wait --destroy-storage";
    };
  };

  home.packages = with pkgs; [
    wl-clipboard

    (nixGLWrap firefox)
  ];
}
