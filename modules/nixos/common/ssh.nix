{
  security = {
    sudo.execWheelOnly = true;
    pam = {
      sshAgentAuth.enable = true;
      services.sudo.sshAgentAuth = true;
    };
  };
}
