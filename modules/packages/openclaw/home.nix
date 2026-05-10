{ ... }:
{ pkgs, inputs, ... }:
let system = pkgs.stdenv.hostPlatform.system;
in {
  imports = [ inputs.openclaw.homeManagerModules.openclaw ];

  programs.openclaw = {
    enable = true;
    package = inputs.openclaw.packages.${system}.openclaw;
  };

  systemd.user.services.openclaw-gateway.Install.WantedBy =
    [ "default.target" ];
}
