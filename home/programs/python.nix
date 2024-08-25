{
  config,
  pkgs,
  lib,
  ...
}: {
  home.sessionPath = ["$HOME/.local/bin"];

  programs.pyenv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.poetry = {
    enable = true;
  };

  home.packages = with pkgs; [
    pipx
    pyright
    python312Packages.nox
    python312Packages.tox
    black
  ];
  programs.zsh.shellAliases = {
    ae = "source venv/bin/activate";
    de = "deactivate";
    envc = "python -m venv venv";
    pipr = "pip install -r requirements.txt";
  };
}
