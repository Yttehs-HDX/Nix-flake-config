{ lib, ... }:

{
  nixpkgs.config = {
    allowUnfree = lib.mkForce true;
    permittedInsecurePackages = [ "openclaw-2026.5.7" ];
  };

  nix = {
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";

    settings = {
      experimental-features = lib.mkAfter [
        "nix-command"
        "flakes"
      ];

      # Keep builds responsive on this 32-thread, 16 GiB laptop.
      max-jobs = 8;
      cores = 16;
    };
  };

  systemd.services.nix-daemon.serviceConfig = {
    MemoryAccounting = true;
    MemoryHigh = "8G";
    MemoryMax = "10G";
    MemorySwapMax = "4G";
    OOMScoreAdjust = 500;
  };

  programs.nix-ld.enable = true;
}
