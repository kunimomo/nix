{ config, lib, pkgs, ... }:

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

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  system.stateVersion = "24.05";
}
