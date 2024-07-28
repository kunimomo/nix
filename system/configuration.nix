{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ./env.nix
  ];

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };

  environment.systemPackages = with pkgs; [
    git
    sudo
    tree
    neovim
    vim
  ];
  
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

}

