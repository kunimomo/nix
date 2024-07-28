{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      pythonPackages = pkgs.python38Packages;
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./system/configuration.nix
        ];
      };

      homeConfigurations = {
        nixos = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
	  modules = [
	    ./home-manager/home.nix
	  ];
        };
      };

      devShell = pkgs.mkShell {
        buildInputs = [
          pythonPackages.mistune
        ];
      };
  };
}
