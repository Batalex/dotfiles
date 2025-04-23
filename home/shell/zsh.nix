{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    autocd = false;
    enableCompletion = false;
    initContent = ''
      bindkey  "^[[H"      beginning-of-line
      bindkey  "^[[F"      end-of-line
      bindkey  "^[[1;5D"   backward-word
      bindkey  "^[[1;5C"   forward-word'';
  };
}
