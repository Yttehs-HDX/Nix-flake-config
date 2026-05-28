{ ... }:

{
  programs.rofi = {
    enable = true;
    modes = [ "run" "drun" "window" "filebrowser" ];
    terminal = "kitty";

    extraConfig = {
      show-icons = true;
      drun-display-format = "{icon} {name}";
      hide-scrollbar = false;
      display-drun = "Apps ";
      display-run = "Run ";
      display-window = "Window";
      display-filebrowser = "File";
      sidebar-mode = true;
    };
  };
}
