{
  description = "My Flake Config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      nebnix = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [./configuration.nix];
        specialArgs = {inherit home-manager;};
      };
    };
  };
}
