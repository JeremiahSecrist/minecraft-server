{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.mine.knorr;
in
{
  options.mine.knorr.enable = lib.mkEnableOption "knorr minecraft";
  config = lib.mkIf cfg.enable {

    virtualisation.podman.enable = true;
    virtualisation.oci-containers.containers."mc" = {
      image = "itzg/minecraft-server";
      autoStart = true;

      ports = [
        "25565:25565"
      ];

      environment = {
        EULA = "TRUE";
        SEED = "ToeSocksDontCount";
        MODRINTH_MODPACK = "jonathans-cobblemon-pack";
        MODRINTH_LOADER = "fabric";
        MODRINTH_DOWNLOAD_DEPENDENCIES = "optional";
        ENABLE_WHITELIST = "true";
        WHITELIST = ''
          1af5fe5b-3f0c-4ac8-a3f7-19dbaca8015b
        '';
        OPS = ''
          1af5fe5b-3f0c-4ac8-a3f7-19dbaca8015b
        '';
      };

      volumes = [
        "/var/lib/minecraft-server/data:/data"
      ];

      extraOptions = [
        "--tty"
        "--interactive"
      ];
    };

    # Ensure the data directory exists
    systemd.tmpfiles.rules = [
      "d /var/lib/minecraft-server/data 0755 root root -"
    ];
  };
}
