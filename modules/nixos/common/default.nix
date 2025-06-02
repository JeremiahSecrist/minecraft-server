{ flake, ... }:
{
  imports =
    with builtins;
    map (fn: ./${fn}) (filter (fn: fn != "default.nix") (attrNames (readDir ./.)))
    ++ [
      flake.inputs.disko.nixosModules.default
    ];
}
