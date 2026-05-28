{ lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = lib.mkAfter [ "nix-command" "flakes" ];
  programs.nix-ld.enable = true;
}
