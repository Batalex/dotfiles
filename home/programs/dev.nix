{pkgs, ...}: {
  home.sessionPath = ["$HOME/.local/bin"];

  home.packages = with pkgs; [
    # python
    pipx
    pyright
    python312Packages.nox
    black
    uv
    ruff

    # rust
    rustup
  ];

  programs.zsh.shellAliases = {
    ae = "source venv/bin/activate";
    de = "deactivate";
    envc = "python -m venv venv";
    pipr = "pip install -r requirements.txt";
  };
}
# TODO: Create a uv module to manage tools
