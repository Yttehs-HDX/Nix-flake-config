{ lib, pkgs, ... }:

{
  nixpkgs.config = {
    nvidia.acceptLicense = true;
    cudaSupport = true;
    allowUnfreePredicate = pkg:
      let name = lib.getName pkg;
      in lib.hasPrefix "cuda" name || lib.hasPrefix "nvidia" name;
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

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
        offloadCmdMainProgram = "prime-run";
      };
      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:2:0";
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
