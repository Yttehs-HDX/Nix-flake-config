{ pkgs, ... }:
let
  screenLockCmd = "swaylock";
  displayOffCmd = "hyprctl dispatch dpms off";
  displayResumeCmd = "hyprctl dispatch dpms on";
in
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = displayResumeCmd;
        ignore_dbus_inhibit = false;
        lock_cmd = screenLockCmd;
      };
      listener = [
        {
          timeout = 300;
          on-timeout = screenLockCmd;
        }
        {
          timeout = 600;
          on-timeout = displayOffCmd;
          on-resume = displayResumeCmd;
        }
      ];
    };
  };
}
