{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    aliases = {
      st = "status";
      fa = "fetch --all --prune";
      co = "checkout";
      ci = "commit";
    };
    ignores = [
      ".tox"
      ".nox"
      ".venv"
      ".DS_Store"
      ".direnv"
    ];
  };

  programs.lazygit.enable = true;

  programs.zsh.shellAliases = {
    lgit = "lazygit";
  };
}
