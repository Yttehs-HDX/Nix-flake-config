{
  pkgs,
  lib,
  ...
}:

let
  mkWorkspaceBinds =
    let
      mkWs = n: ''
        Mod+${toString n} { focus-workspace ${toString n}; }
        Mod+Ctrl+${toString n} { move-window-to-workspace ${toString n}; }
      '';
    in
    lib.concatMapStrings mkWs (lib.range 1 9);

  configKDL = ''
    // ── Input ────────────────────────────────────────────────────────────────
    input {
        keyboard {
            xkb {
                layout "us"
            }
        }
        touchpad {
            tap
            dwt
        }
    }

    // ── Output ───────────────────────────────────────────────────────────────
    // Default monitor settings — adjust per-host as needed.
    // output "eDP-1" {
    //     mode "1920x1080@60"
    //     variable-refresh-rate
    // }

    prefer-no-csd
    hotkey-overlay

    // ── Environment ──────────────────────────────────────────────────────────
    environment {
        XDG_CURRENT_DESKTOP "niri"
        XDG_SESSION_DESKTOP "niri"
        XDG_SESSION_TYPE "wayland"
        GDK_BACKEND "wayland,x11,*"
        GDK_SCALE "1"
        GDK_DPI_SCALE "1"
        NIXOS_OZONE_WL "1"
        ELECTRON_OZONE_PLATFORM_HINT "auto"
        MOZ_ENABLE_WAYLAND "1"
        OZONE_PLATFORM "wayland"
        EGL_PLATFORM "wayland"
        CLUTTER_BACKEND "wayland"
        SDL_VIDEODRIVER "wayland"
        QT_QPA_PLATFORM "wayland;xcb"
        QT_WAYLAND_DISABLE_WINDOWDECORATION "1"
        QT_AUTO_SCREEN_SCALE_FACTOR "1"
    }

    // ── Layout ───────────────────────────────────────────────────────────────
    layout {
        gaps 4
        center-focused-column "never"
        default-column-width { proportion 0.5; }
        border {
            width 2
            active-color "#cba6f7"
            inactive-color "#45475a"
        }
        struts {
            left 0
            right 0
            top 0
            bottom 1
        }
    }

    // ── Animations ───────────────────────────────────────────────────────────
    animations {
        slowdown 3
    }

    // ── Startup ──────────────────────────────────────────────────────────────
    spawn-at-startup "fcitx5" "-d"
    spawn-at-startup "waybar"
    spawn-at-startup "awww"

    // ── Keybindings ──────────────────────────────────────────────────────────
    binds {
        // ── Launch ───────────────────────────────────────────────────────────
        Mod+Q { spawn "kitty"; }
        Mod+R { spawn "rofi" "-show" "drun"; }
        Mod+Escape { spawn "hexecute"; }

        // ── Window management ────────────────────────────────────────────────
        Mod+F { fullscreen-window; }
        Mod+C { close-window; }
        Mod+V { toggle-window-floating; }
        Mod+M { quit; }
        Mod+Shift+F { maximize-column; }

        // ── Focus: vim keys ──────────────────────────────────────────────────
        Mod+H { focus-column-left; }
        Mod+L { focus-column-right; }
        Mod+K { focus-window-up; }
        Mod+J { focus-window-down; }

        // ── Focus: arrow keys ────────────────────────────────────────────────
        Mod+Left  { focus-column-left; }
        Mod+Right { focus-column-right; }
        Mod+Up    { focus-window-up; }
        Mod+Down  { focus-window-down; }

        // ── Move window: vim keys ────────────────────────────────────────────
        Mod+Ctrl+H { move-column-left; }
        Mod+Ctrl+L { move-column-right; }
        Mod+Ctrl+K { move-window-up; }
        Mod+Ctrl+J { move-window-down; }

        // ── Workspaces ───────────────────────────────────────────────────────
    ${mkWorkspaceBinds}
        Mod+0 { focus-workspace 10; }
        Mod+Ctrl+0 { move-window-to-workspace 10; }

        // ── Scroll ───────────────────────────────────────────────────────────
        // Built-in: scrolling on empty area moves the ribbon left/right.
        // Built-in: Mod+scroll switches workspaces.

        // ── Media keys ───────────────────────────────────────────────────────
        XF86AudioNext       { spawn "playerctl" "next"; }
        XF86AudioPause      { spawn "playerctl" "play-pause"; }
        XF86AudioPlay       { spawn "playerctl" "play-pause"; }
        XF86AudioPrev       { spawn "playerctl" "previous"; }
        XF86AudioRaiseVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
        XF86AudioLowerVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
        XF86AudioMute        { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
        XF86AudioMicMute     { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }
        XF86MonBrightnessUp   { spawn "brightnessctl" "s" "5%+"; }
        XF86MonBrightnessDown { spawn "brightnessctl" "s" "5%-"; }
        xf86KbdBrightnessUp   { spawn "brightnessctl" "-d" "*::kbd_backlight" "set" "33%+"; }
        xf86KbdBrightnessDown { spawn "brightnessctl" "-d" "*::kbd_backlight" "set" "33%-"; }

        // ── Utilities ────────────────────────────────────────────────────────
        Mod+W { spawn "sh" "-c" "cliphist list | rofi -dmenu | cliphist decode | wl-copy"; }
        Mod+E { spawn "rofimoji" "--action" "copy" "--prompt" "emoji" "--use-icons"; }
        Print { spawn "screenshot"; }
        Mod+Shift+S { spawn "screenshot"; }
        Mod+Shift+T { spawn "ocr"; }
        Mod+Alt+L { spawn "swaylock"; }
        Mod+Alt+Delete { spawn "hyprpicker" "--autocopy" "--format=hex"; }
    }
  '';
in
{
  home.packages = with pkgs; [
    niri
    xwayland-satellite
    hyprpicker
  ];

  xdg.configFile."niri/config.kdl".text = configKDL;
}
