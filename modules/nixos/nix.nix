{ lib, ... }:

{
  nixpkgs.config = {
    allowUnfree = lib.mkForce true;
    permittedInsecurePackages = [
      "openclaw-2026.5.7"
    ];
  };

  nix.settings.experimental-features = lib.mkAfter [
    "nix-command"
    "flakes"
  ];

  programs.nix-ld.enable = true;
}
