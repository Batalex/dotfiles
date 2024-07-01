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
  };

  outputs = {
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    nixgl,
    ...
  }: let
    pkgs = nixpkgs.legacyPackages.x86-64-linux;
    pkgs-stable = nixpkgs-stable.legacyPackages.x86-64-linux;

    mba-pkgs = nixpkgs.legacyPackages.aarch64-darwin;
    mba-pkgs-stable = nixpkgs-stable.legacyPackages.aarch64-darwin;
  in {
    homeConfigurations = {
      macbook = home-manager.lib.homeManagerConfiguration {
        pkgs = mba-pkgs;
        modules = [./home_common.nix home/mba.nix];
        extraSpecialArgs = {
          inherit mba-pkgs-stable;
        };
      };
      frame = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        overlays = [nixgl.overlay];
        modules = [./home_common.nix home/frame.nix];
      };
    };
  };
}
