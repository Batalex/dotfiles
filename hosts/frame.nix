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

    kubectl

    (nixGLWrap firefox)

    # Will enable only NixOS because I don't want the hassle of messing with
    # AppArmor profiles
    # mattermost-desktop
  ];

  programs.zsh = {
    shellAliases = {
      j = "juju";
      jam = "juju add-model";
      jdm = "juju destroy-model --force --no-wait --destroy-storage";
      jw = "juju status --watch 1s";
    };
    initExtra = ''
      ubuntu-vm() {
        BASE="''${BASE:-noble}"
        VM_NAME="''${VM_NAME:-ubuntu-''${BASE}-$(head -c 2 /dev/urandom | xxd -p -c 32)}"
        DISK="''${DISK:-30}"
        CPU="''${CPU:-8}"
        MEM="''${MEM:-16}"
        EPHEMERAL="''${EPHEMERAL:-true}"

        # Create the VM, but don't start it
        lxc init --vm "ubuntu:''${BASE}" "''${VM_NAME}" \
          -c limits.cpu="''${CPU}" -c limits.memory="''${MEM}GiB" -d root,size="''${DISK}GiB"

        # Mount the $HOME/data directory -> /home/ubuntu/data in the container
        lxc config device add "''${VM_NAME}" datadir disk source="''${HOME}/work" path=/home/ubuntu/work readonly=false

        # Start the container, wait for cloud-init to finish
        lxc start "''${VM_NAME}"

        # Wait for the ubuntu user
        while ! lxc exec "''${VM_NAME}" -- id -u ubuntu &>/dev/null; do sleep 0.5; done

        # Fix broken permissions on ubuntu home directory
        lxc exec "''${VM_NAME}" -- sudo chown ubuntu:ubuntu /home/ubuntu

        # If extra args were specified, run them, else drop to a non-root shell
        if [[ -n "''${1:-}" ]]; then
          lxc exec "''${VM_NAME}" -- bash -c "$*"
        else
          lxc exec "''${VM_NAME}" -- sudo -u ubuntu -i bash
        fi

        # Delete the container when the command exits
        if [[ "''${EPHEMERAL}" == "true" ]]; then
          lxc delete -f "''${VM_NAME}"
        fi
      }

      ubuntu-dev() {
        export EPHEMERAL=false
        export VM_NAME=dev
        export DISK=60
        if [[ $(lxc list -c n | grep -Fc dev) -eq 0 ]]; then
          ubuntu-vm
        else
          lxc exec dev --  sudo -u ubuntu -i bash
        fi
      }
    '';
  };
}
