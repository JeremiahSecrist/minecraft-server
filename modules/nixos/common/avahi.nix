_: {
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      addresses = true;
      enable = true;
      userServices = true;
    };
  };
}
