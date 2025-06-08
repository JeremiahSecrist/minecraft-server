_: {
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
    publish = {
      addresses = true;
      enable = true;
      userServices = true;
    };
  };
}
