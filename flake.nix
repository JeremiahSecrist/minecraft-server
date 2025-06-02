{
  description = "A home-manager template providing useful tools & settings for Nix-based development";

  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2505.*.tar.gz";
    nix-darwin.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2505.*.tar.gz";
    # nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "https://flakehub.com/f/nix-community/home-manager/0.2505.*.tar.gz";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "https://flakehub.com/f/hercules-ci/flake-parts/0.1.372.tar.gz";
    nixos-unified.url = "github:srid/nixos-unified";
    disko.url = "https://flakehub.com/f/nix-community/disko/1.12.0.tar.gz";
    deploy.url = "github:serokell/deploy-rs";
    deploy.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "https://flakehub.com/f/Mic92/sops-nix/0.1.887";
  };

  # Wired using https://nixos-unified.org/autowiring.html
  outputs =
    inputs:
    inputs.nixos-unified.lib.mkFlake {
      inherit inputs;
      root = ./.;
    };
}
