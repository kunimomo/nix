{
  description = "NixOS Configuration with Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      nixosConfigurations = {
        my-hostname = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            {
              imports = [
                ./hardware-configuration.nix
                ./env.nix
              ];

              environment.systemPackages = with pkgs; [
                git
                neovim
                sudo
                vim
              ];

              boot.loader.grub.enable = true;
              boot.loader.grub.device = "/dev/sda";

              networking.hostName = "nixos";
              time.timeZone = "Asia/Tokyo";
              services.sshd.enable = true;

              users.users.nixos = {
                isNormalUser = true;
                extraGroups = [ "wheel" ];
              };

              security.sudo = {
                enable = true;
                wheelNeedsPassword = false;
              };

	      system.stateVersion = "24.05";
            }
          ];
        };
      };
    };
}
