{ config, pkgs, ... }:

let
  initLua = builtins.readFile ./nvim/init.lua;
in
{
  programs.home-manager.enable = true;

  home.stateVersion = "23.05";
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.packages = with pkgs; [
    neovim
    tree
    vim
  ];

  programs = {
    git = {
      enable = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      extraConfig = initLua;
    };
    zsh = {
      enable = true;
      autocd = true;
    };
  };
}

