{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = false;
    initExtra = ''
      bindkey  "^[[H"   beginning-of-line
      bindkey  "^[[F"   end-of-line'';
  };
}
