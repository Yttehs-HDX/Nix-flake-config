{ pkgs, ... }:

{
  services.swaync = {
    enable = true;
    settings = {
      widgets = [
        "mpris"
        "title"
        "dnd"
        "notifications"
      ];
      widget-config.mpris = {
        image-size = 96;
        image-radius = 12;
        blur = true;
      };
    };
  };
}
