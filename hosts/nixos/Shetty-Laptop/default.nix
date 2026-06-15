{ inputs, ... }:

{
  imports = [
    ./asus-numberpad.nix
    ./boot.nix
    ./desktop.nix
    ./firewall.nix
    ./graphics.nix
    ./hardware-configuration.nix
    ./home.nix
    ./locale.nix
    ./users.nix
    ../../../modules/nixos/nix.nix
    ../../../modules/nixos/networking.nix
    ../../../modules/nixos/networkmanager.nix
    ../../../modules/nixos/docker.nix
    ../../../modules/nixos/android.nix
    ../../../modules/nixos/virtualization.nix
    ../../../modules/nixos/nvidia.nix
    ../../../modules/nixos/asus.nix
    ../../../modules/nixos/power.nix
    ../../../modules/nixos/zram.nix
    ../../../modules/nixos/gvfs.nix
    ../../../modules/nixos/wireshark.nix
    ../../../modules/nixos/refind.nix
    ../../../modules/nixos/clash-verge-rev.nix
    ../../../modules/nixos/neovim.nix
    ../../../modules/nixos/zsh.nix
  ];

  networking.hostName = "Shetty-Laptop";

  system.stateVersion = "26.05";
}
