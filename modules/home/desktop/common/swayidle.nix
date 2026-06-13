{ pkgs, ... }:

let
  screenLockCmd = "${pkgs.swaylock-effects}/bin/swaylock -f";
  monitorOffCmd = "${pkgs.niri}/bin/niri msg action power-off-monitors";
  monitorOnCmd = "${pkgs.niri}/bin/niri msg action power-on-monitors";
in
{
  services.swayidle = {
    enable = true;

    extraArgs = [ "-w" ];

    timeouts = [
      {
        timeout = 300;
        command = screenLockCmd;
      }
      {
        timeout = 330;
        command = monitorOffCmd;
        resumeCommand = monitorOnCmd;
      }
    ];

    events = {
      before-sleep = screenLockCmd;
      lock = screenLockCmd;
      unlock = monitorOnCmd;
      after-resume = monitorOnCmd;
    };
  };
}
