{
  pkgs,
  lib,
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
  cliphistToggle = "cliphist list | rofi -dmenu | cliphist decode | wl-copy";
  rofimojiToggle = "rofimoji --action copy --prompt 'emoji' --use-icons";
  screenshotStart = "screenshot";
  ocrStart = "ocr";
  swaylockStart = "swaylock";
  hyprpickerStart = "hyprpicker --autocopy --format=hex";

  # Helper to generate workspace binds
  mkWorkspaceBinds = builtins.concatLists (
    builtins.genList (
      i:
      let
        key = i + 1;
        ws = toString key;
      in
      [
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + ${ws}"'')
            (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "${ws}" })'')
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + SHIFT + ${ws}"'')
            (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "${ws}" })'')
          ];
        }
      ]
    ) 9
  );
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    package = null;
    portalPackage = null;

    configType = "lua";

    settings = {
      mod = {
        _var = "SUPER";
      };

      config = {
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

        xwayland.force_zero_scaling = true;
      };

      env = [
        {
          _args = [
            "XDG_CURRENT_DESKTOP"
            "Hyprland"
          ];
        }
        {
          _args = [
            "XDG_SESSION_DESKTOP"
            "Hyprland"
          ];
        }
        {
          _args = [
            "XDG_SESSION_TYPE"
            "wayland"
          ];
        }
        {
          _args = [
            "GDK_BACKEND"
            "wayland,x11,*"
          ];
        }
        {
          _args = [
            "GDK_SCALE"
            "1"
          ];
        }
        {
          _args = [
            "GDK_DPI_SCALE"
            "1"
          ];
        }
        {
          _args = [
            "NIXOS_OZONE_WL"
            "1"
          ];
        }
        {
          _args = [
            "ELECTRON_OZONE_PLATFORM_HINT"
            "auto"
          ];
        }
        {
          _args = [
            "MOZ_ENABLE_WAYLAND"
            "1"
          ];
        }
        {
          _args = [
            "OZONE_PLATFORM"
            "wayland"
          ];
        }
        {
          _args = [
            "EGL_PLATFORM"
            "wayland"
          ];
        }
        {
          _args = [
            "CLUTTER_BACKEND"
            "wayland"
          ];
        }
        {
          _args = [
            "SDL_VIDEODRIVER"
            "wayland"
          ];
        }
        {
          _args = [
            "QT_QPA_PLATFORM"
            "wayland;xcb"
          ];
        }
        {
          _args = [
            "QT_WAYLAND_DISABLE_WINDOWDECORATION"
            "1"
          ];
        }
        {
          _args = [
            "QT_AUTO_SCREEN_SCALE_FACTOR"
            "1"
          ];
        }
      ];

      exec_cmd = [ fcitxStart ];

      bind = [
        # Terminal
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + Q"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${terminalStart}")'')
          ];
        }
        # Rofi
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + R"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${rofiToggle}")'')
          ];
        }
        # Fullscreen
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + F"'')
            (lib.generators.mkLuaInline "hl.dsp.window.fullscreen()")
          ];
        }
        # Kill active window
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + C"'')
            (lib.generators.mkLuaInline "hl.dsp.window.close()")
          ];
        }
        # Toggle floating
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + V"'')
            (lib.generators.mkLuaInline ''hl.dsp.window.float({ action = "toggle" })'')
          ];
        }
        # # Overview toggle
        # {
        #   _args = [
        #     (lib.generators.mkLuaInline ''mod .. " + TAB"'')
        #     (lib.generators.mkLuaInline "hl.dsp.overview.toggle()")
        #   ];
        # }
        # Hexecute
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + escape"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("hexecute")'')
          ];
        }
        # Exit Hyprland
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + M"'')
            (lib.generators.mkLuaInline "hl.dsp.exit()")
          ];
        }

        # Move focus (arrow keys)
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + left"'')
            (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "l" })'')
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + right"'')
            (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "r" })'')
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + up"'')
            (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "u" })'')
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + down"'')
            (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "d" })'')
          ];
        }

        # Move focus (vim keys)
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + H"'')
            (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "l" })'')
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + L"'')
            (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "r" })'')
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + K"'')
            (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "u" })'')
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + J"'')
            (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "d" })'')
          ];
        }

        # Move window (vim keys)
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + SHIFT + H"'')
            (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "l" })'')
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + SHIFT + L"'')
            (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "r" })'')
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + SHIFT + K"'')
            (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "u" })'')
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + SHIFT + J"'')
            (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "d" })'')
          ];
        }

        # Mouse binds
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + mouse:272"'')
            (lib.generators.mkLuaInline "hl.dsp.window.drag()")
            { mouse = true; }
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + mouse:273"'')
            (lib.generators.mkLuaInline "hl.dsp.window.resize()")
            { mouse = true; }
          ];
        }

        # Workspace scroll
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + mouse_down"'')
            (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "e-1" })'')
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + mouse_up"'')
            (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "e+1" })'')
          ];
        }

        # Media keys (locked)
        {
          _args = [
            "XF86AudioNext"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${playerctlNext}")'')
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86AudioPause"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${playerctlPlayPause}")'')
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86AudioPlay"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${playerctlPlayPause}")'')
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86AudioPrev"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${playerctlPrevious}")'')
            { locked = true; }
          ];
        }

        # Media keys (locked + repeating)
        {
          _args = [
            "XF86AudioRaiseVolume"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${wpctlSetVolumeUp}")'')
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "XF86AudioLowerVolume"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${wpctlSetVolumeDown}")'')
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "XF86AudioMute"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${wpctlSetMute}")'')
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86AudioMicMute"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${wpctlSetMicMute}")'')
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86MonBrightnessUp"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${brightnessctlUp}")'')
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "XF86MonBrightnessDown"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${brightnessctlDown}")'')
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "xf86KbdBrightnessUp"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${brightnessctlKbdUp}")'')
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "xf86KbdBrightnessDown"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${brightnessctlKbdDown}")'')
            {
              locked = true;
              repeating = true;
            }
          ];
        }

        # Clipboard history
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + W"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${cliphistToggle}")'')
          ];
        }
        # Emoji picker
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + E"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${rofimojiToggle}")'')
          ];
        }
        # Screenshot
        {
          _args = [
            "Print"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${screenshotStart}")'')
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + SHIFT + S"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${screenshotStart}")'')
          ];
        }
        # OCR
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + SHIFT + T"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${ocrStart}")'')
          ];
        }
        # Swaylock
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + ALT + L"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${swaylockStart}")'')
          ];
        }
        # Color picker
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + ALT + DELETE"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${hyprpickerStart}")'')
          ];
        }
      ]
      ++ mkWorkspaceBinds
      ++ [
        # Workspace 10
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + 0"'')
            (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "10" })'')
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + SHIFT + 0"'')
            (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "10" })'')
          ];
        }
      ];

      curve = [
        {
          _args = [
            "linear"
            {
              type = "bezier";
              points = [
                [
                  0.0
                  0.0
                ]
                [
                  1.0
                  1.0
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "md3_standard"
            {
              type = "bezier";
              points = [
                [
                  0.2
                  0.0
                ]
                [
                  0.0
                  1.0
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "md3_decel"
            {
              type = "bezier";
              points = [
                [
                  0.05
                  0.7
                ]
                [
                  0.1
                  1.0
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "md3_accel"
            {
              type = "bezier";
              points = [
                [
                  0.3
                  0.0
                ]
                [
                  0.8
                  0.15
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "overshot"
            {
              type = "bezier";
              points = [
                [
                  0.05
                  0.9
                ]
                [
                  0.1
                  1.1
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "crazyshot"
            {
              type = "bezier";
              points = [
                [
                  0.1
                  1.5
                ]
                [
                  0.76
                  0.92
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "hyprnostretch"
            {
              type = "bezier";
              points = [
                [
                  0.05
                  0.9
                ]
                [
                  0.1
                  1.0
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "fluent_decel"
            {
              type = "bezier";
              points = [
                [
                  0.1
                  1.0
                ]
                [
                  0.0
                  1.0
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "easeInOutCirc"
            {
              type = "bezier";
              points = [
                [
                  0.85
                  0.0
                ]
                [
                  0.15
                  1.0
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "easeOutCirc"
            {
              type = "bezier";
              points = [
                [
                  0.0
                  0.55
                ]
                [
                  0.45
                  1.0
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "easeOutExpo"
            {
              type = "bezier";
              points = [
                [
                  0.16
                  1.0
                ]
                [
                  0.3
                  1.0
                ]
              ];
            }
          ];
        }
      ];

      animation = [
        {
          leaf = "windows";
          enabled = true;
          speed = 3;
          bezier = "md3_decel";
          style = "popin 60%";
        }
        {
          leaf = "border";
          enabled = true;
          speed = 10;
          bezier = "default";
        }
        {
          leaf = "fade";
          enabled = true;
          speed = 2.5;
          bezier = "md3_decel";
        }
        {
          leaf = "workspaces";
          enabled = true;
          speed = 3.5;
          bezier = "easeOutExpo";
          style = "slide";
        }
        {
          leaf = "specialWorkspace";
          enabled = true;
          speed = 3;
          bezier = "md3_decel";
          style = "slidevert";
        }
      ];

      layer_rule = [
        {
          match.namespace = "rofi";
          blur = true;
          ignore_alpha = 0.0;
        }
        {
          match.namespace = "waybar";
          blur = true;
          ignore_alpha = 0.0;
        }
      ];
    };

    plugins = [
      # pkgs.hyprlandPlugins."hypr-dynamic-cursors"
    ];
  };
}
