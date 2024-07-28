{ config, pkgs, ... }:

{
  home.stateVersion = "24.05";
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.packages = with pkgs; [
  ];
}
