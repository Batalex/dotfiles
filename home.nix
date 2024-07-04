{
  config,
  pkgs,
  ...
}: {
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    yq

    tldr
    btop
    dprint
    vale

    pipx
    pyright
    ruff-lsp

    (nerdfonts.override {fonts = ["CommitMono"];})
  ];

  home.file = {
    "dprint.json".source = ./apps/dprint/dprint.json;
    ".config/zellij/config.kdl".source = ./apps/zellij/config.kdl;
    ".config/zellij/themes/catpuccin.kdl".source = ./apps/zellij/themes/catppuccin.kdl;
    ".config/vale/.vale.ini".source = ./apps/vale/.vale.ini;
  };

  home.sessionVariables = {
    EDITOR = "hx";
    VALE_CONFIG_PATH = "~/.config/vale/.vale.ini";
  };

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    shellAliases = {
      zj = "zellij";
      lgit = "lazygit";
      ae = "source venv/bin/activate";
      de = "deactivate";
      envc = "python -m venv venv";
      pipr = "pip install -r requirements.txt";
    };
  };

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

  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML apps/starship/starship.toml;
    enableZshIntegration = true;
  };

  programs.helix = {
    enable = true;
    settings = pkgs.lib.importTOML apps/helix/config.toml;
    languages = pkgs.lib.importTOML apps/helix/languages.toml;
    defaultEditor = true;
  };

  programs.zellij.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.lazygit.enable = true;

  programs.ripgrep.enable = true;

  programs.fzf.enable = true;

  programs.btop.enable = true;

  programs.pyenv = {
    enable = true;
    enableZshIntegration = true;
  };
}
