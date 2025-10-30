{...}: {
  programs.git = {
    enable = true;
    includes = [
      {
        condition = "gitdir:~/dev/";
        contents.user.email = "alex.batisse@canonical.com";
      }
    ];
    ignores = [
      ".tox"
      ".nox"
      ".venv"
      ".DS_Store"
      ".envrc"
      ".direnv"
    ];
    settings = {
      user.email = "alexandre.batisse@hey.com";
      user.name = "Alex Batisse";
      alias = {
        st = "status";
        fa = "fetch --all --prune";
        co = "checkout";
        ci = "commit";
        wt = "worktree";
        cp = "cherry-pick";
      };

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
      git.overrideGpg = true;
    };
  };

  programs.zsh.shellAliases = {
    lgit = "lazygit";
  };

  programs.gh.enable = true;

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      dark = true;
    };
  };
}
