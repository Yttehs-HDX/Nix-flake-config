{ pkgs, ... }:

let
  screenLockCmd = "${pkgs.swaylock-effects}/bin/swaylock";
in
{
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = screenLockCmd;
      }
      {
        timeout = 600;
        command = "${pkgs.niri}/bin/niri msg action power-off-monitors";
        resumeCommand = "${pkgs.niri}/bin/niri msg action power-on-monitors";
      }
    ];
    events = {
      before-sleep = screenLockCmd;
      lock = screenLockCmd;
    };
  };
}
