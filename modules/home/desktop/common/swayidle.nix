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

    events = [
      {
        event = "before-sleep";
        command = screenLockCmd;
      }
      {
        event = "lock";
        command = screenLockCmd;
      }
      {
        event = "unlock";
        command = monitorOnCmd;
      }
      {
        event = "after-resume";
        command = monitorOnCmd;
      }
    ];
  };
}
