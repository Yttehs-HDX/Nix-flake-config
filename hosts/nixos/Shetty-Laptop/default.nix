{ inputs, ... }:

{
  imports = [
    ./boot.nix
    ./locale.nix
    ./graphics.nix
    ./hardware-configuration.nix
    ./users.nix
    ./desktop.nix
    ./home.nix

    ../../../modules/nixos/nix.nix
    ../../../modules/nixos/networking.nix
    ../../../modules/nixos/firewall.nix
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

  system.stateVersion = "25.11";
}
