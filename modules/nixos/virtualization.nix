{ ... }:

{
  programs.virt-manager.enable = true;
  virtualisation.waydroid.enable = true;

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
}
