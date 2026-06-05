{ pkgs, ... }:

{
  # Use polkit-gnome as the polkit authentication agent (generic wlroots, works with niri).
  # The NixOS `programs.niri.enable` already pulls in polkit, keyring, and portals.
  systemd.user.services.polkit-gnome-authentication-agent = {
    Unit = {
      Description = "polkit-gnome-authentication-agent";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
