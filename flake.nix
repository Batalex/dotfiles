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
    pkgs_with_nixgl = import nixpkgs {
      system = "x86_64-linux";
      overlays = [nixgl.overlay];
    };
    pkgs-stable = nixpkgs-stable.legacyPackages.x86_64-linux;

    mba-pkgs = nixpkgs.legacyPackages.aarch64-darwin;
    mba-pkgs-stable = nixpkgs-stable.legacyPackages.aarch64-darwin;
  in {
    homeConfigurations = {
      mba = home-manager.lib.homeManagerConfiguration {
        pkgs = mba-pkgs;
        modules = [hosts/mba.nix];
        extraSpecialArgs = {
          pkgs-stable = mba-pkgs-stable;
        };
      };
      frame = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs_with_nixgl;
        modules = [hosts/frame.nix];
        extraSpecialArgs = {
          inherit pkgs-stable;
        };
      };
    };
  };
}
