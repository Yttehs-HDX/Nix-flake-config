{ pkgs, ... }:

{
  home.packages = [ pkgs.clash-verge-rev ];

  systemd.user.services.clash-verge-rev = {
    Unit = {
      Description = "Clash Verge Rev";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.clash-verge-rev}/bin/clash-verge";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
