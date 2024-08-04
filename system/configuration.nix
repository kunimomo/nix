{ config, pkgs, lib,  ... }:

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

  # ブートローダー設定
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  # ユーザー設定
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  systemd.services.systemd-oomd = {
    enable = false;
    wantedBy = lib.mkForce [];
  };
}
