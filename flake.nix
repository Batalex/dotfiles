{
  description = "Home Manager configuration and dotfiles";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    craft-ls = {
      url = "https://flakehub.com/f/Batalex/craft-ls/0.2.1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    nixgl,
    craft-ls,
    ...
  }: let
    pkgs_with_nixgl = import nixpkgs {
      system = "x86_64-linux";
      overlays = [nixgl.overlay];
      config.allowUnfree = true;
    };
    pkgs-stable = nixpkgs-stable.legacyPackages.x86_64-linux;

    mba-pkgs = import nixpkgs {
      system = "aarch64-darwin";
      config.allowUnfree = true;
    };
    mba-pkgs-stable = nixpkgs-stable.legacyPackages.aarch64-darwin;
  in {
    homeConfigurations = {
      mba = home-manager.lib.homeManagerConfiguration {
        pkgs = mba-pkgs;
        modules = [hosts/mba.nix];
        extraSpecialArgs = {
          pkgs-stable = mba-pkgs-stable;
          craft-ls = craft-ls;
        };
      };
      frame = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs_with_nixgl;
        modules = [hosts/frame.nix];
        extraSpecialArgs = {
          inherit pkgs-stable;
          craft-ls = craft-ls;
        };
      };
    };
  };
}
