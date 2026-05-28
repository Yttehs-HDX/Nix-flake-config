{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./users.nix
    ./desktop.nix
    ./home.nix

    ../../../modules/nixos/nix.nix
    ../../../modules/nixos/networking.nix
    ../../../modules/nixos/bluetooth.nix
    ../../../modules/nixos/audio.nix
    ../../../modules/nixos/fonts.nix
    ../../../modules/nixos/docker.nix
    ../../../modules/nixos/android.nix
    ../../../modules/nixos/virtualization.nix
    ../../../modules/nixos/nvidia.nix
    ../../../modules/nixos/asus.nix
    ../../../modules/nixos/power.nix
    ../../../modules/nixos/zram.nix
    ../../../modules/nixos/gvfs.nix
    ../../../modules/nixos/gnome-keyring.nix
    ../../../modules/nixos/blueman.nix
    ../../../modules/nixos/wireshark.nix
    ../../../modules/nixos/refind.nix
    ../../../modules/nixos/clash-verge.nix
    ../../../modules/nixos/udisks2.nix
    ../../../modules/nixos/neovim.nix
  ];

  programs.zsh.enable = true;

  networking.hostName = "Shetty-Laptop";

  system.stateVersion = "25.11";
}
