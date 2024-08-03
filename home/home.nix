{ config, pkgs, ... }:

{

  programs.home-manager.enable = true;

  home.stateVersion = "23.05";
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.packages = with pkgs; [
    git
    tree
    neovim
    vim
  ];

  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
  };

  programs.git = {
    enable = true;
  };

  programs.neovim = {
    enable = true;
  }
}
