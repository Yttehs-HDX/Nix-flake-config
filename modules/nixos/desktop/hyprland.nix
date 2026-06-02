{ pkgs, ... }:

{
  imports = [
    ./common/audio.nix
    ./common/bluetooth.nix
    ./common/blueman.nix
    ./common/gnome-keyring.nix
    ./common/portal.nix
    ./common/udisks2.nix
    ./common/polkit.nix
    ./common/dbus.nix
    ./sddm.nix
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # environment.systemPackages = with pkgs; [
  #   xdg-utils wl-clipboard grim slurp
  # ];
}
