{
  pkgs,
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

  imports = [../home];

  services.ssh-agent.enable = true;
  programs.alacritty = {
    package = nixGLWrap pkgs.alacritty;
    settings = {
      font.size = 15;
      window.padding = {
        x = 6;
        y = 6;
      };
    };
  };

  home.packages = with pkgs; [
    wl-clipboard

    (nixGLWrap firefox)
    mattermost-desktop
  ];

  programs.zsh = {
    shellAliases = {
      j = "juju";
      jam = "juju add-model";
      jdm = "juju destroy-model --force --no-wait --destroy-storage";
      jw = "juju status --watch 1s";
    };
  };
}
