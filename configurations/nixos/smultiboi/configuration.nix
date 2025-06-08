{ config, pkgs, ... }:
{
  disko.devices.disk.main.device = "/dev/vda";

  users.users.admin = {
    isNormalUser = true;

    name = "sky";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "input"
    ];
    uid = 1000;
    openssh.authorizedKeys.keys = config.users.users.root.openssh.authorizedKeys.keys;
  };
  users.users.root.openssh.authorizedKeys.keys = [
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBA9i9HoP7X8Ufzz8rAaP7Nl3UOMZxQHMrsnA5aEQfpTyIQ1qW68jJ4jGK5V6Wv27MMc3czDU1qfFWIbGEWurUHQ="
  ];
  services.tailscale = {
    enable = true;
  };
  mine.knorr.enable = true;
  services.tty-ips.enable = true;
  networking.yggdrasil.enable = true;
  networking.yggdrasil.AllowedPublicKeys = [
    "d0e265fcf663451ae9bc048dc1297749819ce9d48042a986f2866c15a779a074"
  ];
  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "smultiboi";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = "25.05";
}
