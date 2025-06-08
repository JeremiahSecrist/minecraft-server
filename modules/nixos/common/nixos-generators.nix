{ flake, ... }:
{
  imports = [
    flake.inputs.nixos-generators.nixosModules.all-formats
  ];
}
