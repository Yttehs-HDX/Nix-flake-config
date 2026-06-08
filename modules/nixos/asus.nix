{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.asusctl ];

  services.asusd.enable = true;

  programs.rog-control-center = {
    enable = true;
    autoStart = true;
  };

  services.supergfxd.enable = true;
}
