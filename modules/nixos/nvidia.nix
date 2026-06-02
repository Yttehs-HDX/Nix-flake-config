{ lib, pkgs, ... }:

{
  nixpkgs.config = {
    nvidia.acceptLicense = true;
    cudaSupport = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    nvidiaSettings = true;

    powerManagement = {
      enable = true;
      finegrained = true;
    };

    prime.offload = {
      enable = true;
      enableOffloadCmd = true;
      offloadCmdMainProgram = "prime-run";
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };
}
