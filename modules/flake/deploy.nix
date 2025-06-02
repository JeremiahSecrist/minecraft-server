{ inputs, ... }:
let
  inherit (inputs)
    self
    deploy-rs
    nixpkgs
    nixos-anywhere
    agenix
    ;
  inherit (nixpkgs) lib;

  genNode =
    hostName: nixosCfg:
    let
      # inherit (self.hosts.${hostName}) address hostPlatform remoteBuild;
      # inherit (deploy-rs.lib.${hostPlatform}) activate;
      system = self.nixosConfigurations."${hostName}".pkgs.system;
    in
    {
      hostname = hostName;
      profiles.system.path = deploy-rs.lib.${system}.activate.nixos self.nixosConfigurations.${hostName};
    };
in
{
  perSystem =
    {
      system,
      ...
    }:
    {
      apps = rec {
        default = deploy;
        secrets = {
          type = "app";
          program = "${agenix.packages.${system}.agenix}/bin/agenix";
          meta.description = "";
        };
        install = {
          type = "app";
          program = "${nixos-anywhere.packages.${system}.nixos-anywhere}/bin/nixos-anywhere";
          meta.description = "";
        };
        deploy = deploy-rs.apps.${system}.deploy-rs;
      };
    };
  flake = {
    deploy = {
      autoRollback = false;
      magicRollback = true;
      user = "root";
      remoteBuild = true;
      nodes = lib.mapAttrs genNode (self.nixosConfigurations or { });
    };
  };
}
