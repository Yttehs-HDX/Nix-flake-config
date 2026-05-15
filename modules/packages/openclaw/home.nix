{ ... }:
{ lib, pkgs, inputs, ... }:
let system = pkgs.stdenv.hostPlatform.system;
in {
  imports = [ inputs.openclaw.homeManagerModules.openclaw ];

  programs.openclaw = {
    enable = true;
    package = inputs.openclaw.packages.${system}.openclaw;
  };

  # Keep user-managed OpenClaw settings across reboot/home-manager activation.
  home.file.".openclaw/openclaw.json".enable = lib.mkForce false;

  systemd.user.services.openclaw-gateway.Install.WantedBy =
    [ "default.target" ];
}
