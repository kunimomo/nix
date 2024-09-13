# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        nixosConfigurations = {
          nixos = nixpkgs.lib.nixosSystem {
            system = system;
            modules = [
              ./system/configuration.nix
              home-manager.nixosModules.home-manager
            ];
          };
        };

        homeConfigurations = {
          myHome = home-manager.lib.homeManagerConfiguration {
            pkgs = pkgs;
	    modules = [
	      ./home-manager/home.nix
	    ];
          };
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.python38Packages.mistune_2
          ];
        };
      }
    );
}
