{ flake, ... }:
{
  imports =
    with builtins;
    map (fn: ./${fn}) (filter (fn: fn != "default.nix") (attrNames (readDir ./.)))
    ++ [
      flake.inputs.disko.nixosModules.default
    ];

  services.avahi.enable = true;
}
