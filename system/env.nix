{ config, pkgs, ... }:

let
  secrets = builtins.readFile ./secrets.sh;
  sshPublicKey = builtins.getEnv "SSH_PUBLIC_KEY";
in {
  # SSHサービスの設定
  services.openssh.settings = {
    enable = true;
    passwordAuthentication = false;
  };

  # tailscaleの設定
  #environment.systemPackages = [ pkgs.tailscale ];
  #services.tailscale.enable = true;
  #networking.firewall = {
    #enable = true;
    #trustedInterfaces = [ "tailscale0" ];
    #allowedUDPPorts = [ config.services.tailscale.port ];
    #allowedTCPPorts = [ 22 ];
  #};

  # ユーザー設定
  users.users.nixos = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [ sshPublicKey ];
  };

  # ネットワーク設定
  networking.interfaces.ens18 = {
    ipv4.addresses = [{
      address =  "192.168.0.3"; 
      prefixLength = 24;
    }];
  };
  
  networking.defaultGateway = "192.168.0.1";
  networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];
}
