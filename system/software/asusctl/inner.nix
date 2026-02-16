{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ asusctl ];

  services.asusd = {
    enable = true;
    enableUserService = true;
  };
}
