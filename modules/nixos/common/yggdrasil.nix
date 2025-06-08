{
  config,
  lib,
  ...
}:
let
  inherit (lib)
    mkOption
    mkEnableOption
    mkIf
    types
    ;
  cfg = config.networking.yggdrasil;
in
{
  options.networking.yggdrasil = {
    enable = mkEnableOption "enables yggdrasil a sdwan solution";
    AllowedPublicKeys = mkOption {
      type = with types; listOf str;
      default = [ "" ];
    };
  };
  config = mkIf cfg.enable {
    users = {
      users.yggdrasil = {
        isSystemUser = true;
        description = "Yggdrasil";
        group = "yggdrasil";
        uid = 728;
      };
      groups.yggdrasil.gid = 728;
    };

    systemd.services.yggdrasil = {
      serviceConfig = {
        DynamicUser = lib.mkForce false;
        User = "yggdrasil";
        RestrictNamespaces = lib.mkForce "no";
      };
    };
    services.yggdrasil = {
      enable = true;
      persistentKeys = true;
      openMulticastPort = true;
      settings = {
        Peers = [
          "tls://ygg.yt:443"
          "tls://ygg.jjolly.dev:3443"
          "quic://ygg-kcmo.incognet.io:8885"
        ];
        MulticastInterfaces = [
          {
            Regex = "w.*";
            Beacon = true;
            Listen = true;
            Port = 9001;
            Priority = 0;
          }
        ];
        AllowedPublicKeys = [ ];
        IfName = "ygg0";
        IfMTU = 65535;
        NodeInfoPrivacy = false;
        NodeInfo = null;
      };
    };
  };
}
