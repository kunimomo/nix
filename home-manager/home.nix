{ config, pkgs, ... }:

{
  home.username = "kunimomo";
  home.homeDirectory = "/Users/kunimomo";
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
  
  home.packages = with pkgs; [
    git
    vim
    tmux
  ];
}
