{ ... }:

{
  services.asus-numberpad-driver = {
    enable = true;

    # ROG Strix G614JI
    layout = "g533";

    wayland = true;

    # niri uses wayland-1 by default
    waylandDisplay = "wayland-1";

    config = {
      "activation_time" = "0.5";
      "sys_numlock_enables_numpad" = "1";
      "enabled_touchpad_pointer" = "0";
    };
  };
}
