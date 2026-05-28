{
  pkgs,
  ...
}:

let
  fcitxStart = "fcitx5 -d";
  playerctlNext = "playerctl next";
  playerctlPlayPause = "playerctl play-pause";
  playerctlPrevious = "playerctl previous";
  wpctlSetVolumeUp = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
  wpctlSetVolumeDown = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
  wpctlSetMute = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
  wpctlSetMicMute = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
  brightnessctlUp = "brightnessctl s 5%+";
  brightnessctlDown = "brightnessctl s 5%-";
  brightnessctlKbdUp = "brightnessctl -d *::kbd_backlight set 33%+";
  brightnessctlKbdDown = "brightnessctl -d *::kbd_backlight set 33%-";
  terminalStart = "kitty";
  rofiToggle = "rofi -show drun";
  hyprctlDispatchToggleFloating = "hyprctl dispatch togglefloating";
  hyprctlDispatchExit = "hyprctl dispatch exit";
  cliphistToggle = "cliphist list | rofi -dmenu | cliphist decode | wl-copy";
  rofimojiToggle = "rofimoji --action copy --prompt 'emoji' --use-icons";
  screenshotStart = "screenshot";
  ocrStart = "ocr";
  swaylockStart = "swaylock";
  hyprpickerStart = "hyprpicker --autocopy --format=hex";
in
{
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

      exec-once = [ fcitxStart ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindl = [
        ", XF86AudioNext, exec, ${playerctlNext}"
        ", XF86AudioPause, exec, ${playerctlPlayPause}"
        ", XF86AudioPlay, exec, ${playerctlPlayPause}"
        ", XF86AudioPrev, exec, ${playerctlPrevious}"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, ${wpctlSetVolumeUp}"
        ", XF86AudioLowerVolume, exec, ${wpctlSetVolumeDown}"
        ", XF86AudioMute, exec, ${wpctlSetMute}"
        ", XF86AudioMicMute, exec, ${wpctlSetMicMute}"
        ", XF86MonBrightnessUp, exec, ${brightnessctlUp}"
        ", XF86MonBrightnessDown, exec, ${brightnessctlDown}"
        ", xf86KbdBrightnessUp, exec, ${brightnessctlKbdUp}"
        ", xf86KbdBrightnessDown, exec, ${brightnessctlKbdDown}"
      ];

      bind = [
        "$mod, Q, exec, ${terminalStart}"
        "$mod, R, exec, ${rofiToggle}"
        "$mod, F, fullscreen"
        "$mod, C, killactive"
        "$mod, V, exec, ${hyprctlDispatchToggleFloating}"
        "$mod, TAB, hyprexpo:expo, toggle"
        "$mod, escape, exec, hexecute"
        "$mod, M, exec, ${hyprctlDispatchExit}"

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

        "$mod, W, exec, ${cliphistToggle}"
        "$mod, E, exec, ${rofimojiToggle}"
        ", Print, exec, ${screenshotStart}"
        "$mod SHIFT, S, exec, ${screenshotStart}"
        "$mod SHIFT, T, exec, ${ocrStart}"
        "$mod ALT, L, exec, ${swaylockStart}"
        "$mod ALT, DELETE, exec, ${hyprpickerStart}"
      ]
      ++ builtins.concatLists (
        builtins.genList (
          i:
          let
            key = i + 1;
            ws = toString key;
          in
          [
            "$mod, ${ws}, workspace, ${ws}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${ws}"
          ]
        ) 9
      )
      ++ [
        "$mod, 0, workspace, 10"
        "$mod SHIFT, 0, movetoworkspace, 10"
      ];

      general = {
        gaps_in = 2;
        gaps_out = 4.5;
        border_size = 2;
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

      layerrule = [
        "blur,rofi"
        "ignorezero,rofi"
        "blur,waybar"
        "ignorezero,waybar"
      ];

      plugin = {
        hyprexpo = {
          columns = 3;
          gap_size = 4;
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
