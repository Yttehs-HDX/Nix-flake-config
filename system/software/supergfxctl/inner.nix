{ pkgs, ... }:

{
  services.supergfxd.enable = true;

  # https://asus-linux.org/guides/nixos/
  # If it fails know that a fix is on the way,
  # but until it gets merged you can add this line to make it work:
  # systemd.services.supergfxd.path = [ pkgs.pciutils ];
}
