{
  # SSHサービスの設定
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

  # ユーザー設定
  users.users.nixos = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [ (builtins.getEnv "SSH_PUBLIC_KEY") ];
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
