{
  description = "My Flake Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      nebnix = lib.nixosSystem {
        system = "aarch64-linux";
        modules = [./configuration.nix];
        specialArgs = {inherit home-manager;};
      };
    };

/*
    homeConfigurations = {
      neb = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."aarch64-linux";
        modules = [./home.nix];
      };
    };
*/
  };
}
