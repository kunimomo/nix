# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
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
    };
}
