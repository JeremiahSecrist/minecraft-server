{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkOption mkIf types;
in
{
  options.services.tty-ips = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Show interface IPs in TTY login using a dynamic issue file.";
    };
  };

  config = mkIf config.services.tty-ips.enable {
    systemd.services.tty-ips = {
      description = "Generate /run/issue.dynamic with interface IPs";
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      requires = [ "network-online.target" ];
      before = [ "getty@tty1.service" ];

      serviceConfig =
        let
          sw = "/run/current-system/sw/bin";
        in
        {
          Type = "oneshot";
          ExecStart = pkgs.writeShellScript "tty-ips-generate" ''
            echo "Welcome to NixOS!" > /run/issue.dynamic
            echo "" >> /run/issue.dynamic
            echo "IP Addresses:" >> /run/issue.dynamic
            ${sw}/ip -brief addr show ygg0 | ${sw}/awk '{print "  " $3}v' | ${pkgs.qrencode}/bin/qrencode -t ANSIUTF8 >> /run/issue.dynamic
            echo "" >> /run/issue.dynamic
          '';
        };
    };

    services.getty.extraArgs = [
      "--issue-file"
      "/run/issue.dynamic"
    ];
  };
}
