{...}: {
  programs.git = {
    enable = true;
    userEmail = "alexandre.batisse@hey.com";
    userName = "Alex Batisse";
    includes = [
      {
        condition = "gitdir:~/work/";
        contents.user.email = "alex.batisse@canonical.com";
      }
    ];
    aliases = {
      st = "status";
      fa = "fetch --all --prune";
      co = "checkout";
      ci = "commit";
      wt = "worktree";
      cp = "cherry-pick";
    };
    ignores = [
      ".tox"
      ".nox"
      ".venv"
      ".DS_Store"
      ".envrc"
      ".direnv"
    ];
    delta = {
      enable = true;
      options = {
        dark = true;
      };
    };
    extraConfig = {
      gpg = {
        format = "ssh";
        ssh = {
          allowedSignersFile = "~/.ssh/allowed_signers";
        };
      };
      user.signingKey = "~/.ssh/id_ed25519.pub";
      commit.gpgSign = true;
      tag.gpgSign = true;
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      os.copyToClipboardCmd = ''printf "\033]52;c;$(printf {{text}} | base64 -w 0)\a" > /dev/tty'';
      git.autoStageResolvedConflicts = false;
    };
  };

  programs.zsh.shellAliases = {
    lgit = "lazygit";
  };
}
