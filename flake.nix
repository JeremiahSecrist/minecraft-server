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
    agenix = {
      url = "github:ryantm/agenix";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    disko.url = "https://flakehub.com/f/nix-community/disko/1.12.0.tar.gz";
    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nixos-anywhere.url = "github:nix-community/nixos-anywhere/1.10.0";
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
