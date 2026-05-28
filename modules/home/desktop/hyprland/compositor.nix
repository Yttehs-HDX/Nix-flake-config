{ config, lib, pkgs, ... }:

let rgba = color: alpha: "rgba(${lib.removePrefix "#" color}${alpha})";
in {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    package = null;
    portalPackage = null;

    settings = {
      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "GDK_BACKEND,wayland,x11,*"
        "GDK_SCALE,1"
        "GDK_DPI_SCALE,1"
        "NIXOS_OZONE_WL,1"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "MOZ_ENABLE_WAYLAND,1"
        "OZONE_PLATFORM,wayland"
        "EGL_PLATFORM,wayland"
        "CLUTTER_BACKEND,wayland"
        "SDL_VIDEODRIVER,wayland"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      ];

      "$mod" = "SUPER";

      exec-once = [ "fcitx5 -d" ];

      bindm = [ "$mod, mouse:272, movewindow" "$mod, mouse:273, resizewindow" ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl s 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
        ", xf86KbdBrightnessUp, exec, brightnessctl -d *::kbd_backlight set 33%+"
        ", xf86KbdBrightnessDown, exec, brightnessctl -d *::kbd_backlight set 33%-"
      ];

      bind = [
        "$mod, Q, exec, kitty"
        "$mod, R, exec, rofi -show drun"
        "$mod, F, fullscreen"
        "$mod, C, killactive"
        "$mod, V, exec, hyprctl dispatch togglefloating"
        "$mod, TAB, hyprexpo:expo, toggle"
        "$mod, escape, exec, hexecute"
        "$mod, M, exec, hyprctl dispatch exit"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"

        "$mod, mouse_down, workspace, e-1"
        "$mod, mouse_up, workspace, e+1"

        "$mod, W, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "$mod, E, exec, rofimoji --action copy --prompt 'emoji' --use-icons"
        ", Print, exec, grimblast copy area"
        "$mod SHIFT, S, exec, grimblast copy area"
        "$mod SHIFT, T, exec, ocr"
        "$mod ALT, L, exec, swaylock-themed"
        "$mod ALT, DELETE, exec, hyprpicker -a"
      ] ++ builtins.concatLists (builtins.genList (i:
        let
          key = i + 1;
          ws = toString key;
        in [
          "$mod, ${ws}, workspace, ${ws}"
          "$mod SHIFT, ${ws}, movetoworkspace, ${ws}"
        ]) 9)
        ++ [ "$mod, 0, workspace, 10" "$mod SHIFT, 0, movetoworkspace, 10" ];

      general = {
        gaps_in = 2;
        gaps_out = 4.5;
        border_size = 2;
        "col.active_border" =
          "${rgba "#cba6f7" "ff"} ${rgba "#f5e0dc" "ff"} 45deg";
        "col.inactive_border" =
          "${rgba "#b4befe" "cc"} ${rgba "#6c7086" "cc"} 45deg";
        resize_on_border = true;
        layout = "dwindle";
      };

      decoration = {
        shadow.enabled = false;
        rounding = 10;
        dim_special = 0.3;
        blur = {
          enabled = true;
          special = true;
          size = 6;
          passes = 2;
          new_optimizations = true;
          ignore_opacity = true;
          xray = false;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "fluent_decel, 0.1, 1, 0, 1"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
        ];
        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 2.5, md3_decel"
          "workspaces, 1, 3.5, easeOutExpo, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };

      layerrule =
        [ "blur,rofi" "ignorezero,rofi" "blur,waybar" "ignorezero,waybar" ];

      plugin = {
        hyprexpo = {
          columns = 3;
          gap_size = 4;
          bg_col = rgba "#1e1e2e" "cc";
          workspace_method = "center current";
          gesture_distance = 300;
        };

        dynamic-cursors = {
          enabled = true;
          mode = "tilt";
        };
      };

      xwayland.force_zero_scaling = true;
    };

    plugins = [
      pkgs.hyprlandPlugins.hyprexpo
      pkgs.hyprlandPlugins."hypr-dynamic-cursors"
    ];

  };
}
