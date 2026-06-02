{
  config,
  lib,
  pkgs,
  ...
}:

let
  homeDir = config.home.homeDirectory;
in
{
  home.packages = [ pkgs.openclaw ];

  home.activation.openclawPrepareDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${homeDir}/.openclaw"
    mkdir -p "${homeDir}/.openclaw/workspace"
    mkdir -p "/tmp/openclaw"
  '';

  systemd.user.services.openclaw-gateway = {
    Unit = {
      Description = "OpenClaw gateway";
      After = [ "network-online.target" ];
    };
    Service = {
      ExecStart = "${pkgs.openclaw}/bin/openclaw gateway --port 18789";
      WorkingDirectory = "${homeDir}/.openclaw";
      Restart = "always";
      RestartSec = "1s";
      Environment = [
        "HOME=${homeDir}"
        "OPENCLAW_STATE_DIR=${homeDir}/.openclaw"
        "OPENCLAW_CONFIG_PATH=${homeDir}/.openclaw/openclaw.json"
      ];
    };
    Install.WantedBy = [ "default.target" ];
  };
}
