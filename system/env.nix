{
  services.openssh.enable = true;

  networking.interfaces.ens18 = {
    ipv4.addresses = [{
      address = "192.168.0.3";
      prefixLength = 24;
    }];
  };

  networking.defaultGateway = "192.168.0.1";
  networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];
}

