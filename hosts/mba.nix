{
  pkgs,
  craft-ls,
  ...
}: {
  home.username = "abatisse";
  home.homeDirectory = "/Users/abatisse";

  imports = [../home];

  home.packages = [
    pkgs.typst
    craft-ls.packages.aarch64-darwin.default
  ];

  programs.alacritty.settings = {
    font.size = 16;
    window.option_as_alt = "OnlyLeft";
    window.padding = {
      x = 6;
      y = 6;
    };
    keyboard.bindings = [
      {
        key = "N";
        mods = "Command";
        action = "CreateNewWindow";
      }
    ];
  };
}
