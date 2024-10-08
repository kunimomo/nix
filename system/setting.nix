{ config, pkgs, ... }:

let
  secrets = builtins.readFile ./env.sh;
  sshPublicKey = builtins.getEnv "SSH_PUBLIC_KEY";
in {
  # SSHサービスの有効化
  services.openssh.enable = true;
  # SSHサービスの設定
  services.openssh = {
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

  # ネットワーク設定
  networking.interfaces.ens18 = {
    ipv4.addresses = [{
      address =  "192.168.0.3"; 
      prefixLength = 24;
    }];
  };

  networking = {
    defaultGateway = "192.168.0.1";
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };
  };

  # tailscaleの設定
  environment.systemPackages = [ pkgs.tailscale ];
  services.tailscale = {
    enable = true;
  };

  # ユーザー設定
  users.users.nixos = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [ sshPublicKey ];
  };
}
