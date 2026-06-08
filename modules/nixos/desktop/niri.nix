{ pkgs, ... }:

{
  imports = [
    ./common/audio.nix
    ./common/bluetooth.nix
    ./common/blueman.nix
    ./common/portal.nix
    ./common/udisks2.nix
    ./common/polkit.nix
    ./common/dbus.nix
    ./sddm.nix
    ../theme/catppuccin-mocha
  ];

  programs.niri.enable = true;

  security.pam.services = {
    niri = { };
    swaylock = { };
  };
}
