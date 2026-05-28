{ lib, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.main = {
      layer = "top";
      position = "top";
      mode = "dock";
      height = 38;
      exclusive = true;
      passthrough = false;
      gtk-layer-shell = true;
      ipc = true;
      fixed-center = true;
      margin-top = 5;
      margin-left = 3;
      margin-right = 3;
      margin-bottom = 2;

      modules-left = [ "group/hyprland" "cava" ];
      modules-center = [ "group/misc" ];
      modules-right =
        [ "group/monitor" "group/connection" "group/quick" "group/power" ];

      "group/hyprland" = {
        orientation = "horizontal";
        modules = [ "hyprland/workspaces" "hyprland/window" ];
      };

      "hyprland/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
        active-only = false;
        format = "{icon}";
        format-icons = {
          "1" = "壱";
          "2" = "弐";
          "3" = "参";
          "4" = "肆";
          "5" = "伍";
          "6" = "陸";
          "7" = "漆";
          "8" = "捌";
          "9" = "玖";
          "10" = "拾";
        };
        on-click = "activate";
        persistent-workspaces = { "*" = [ 1 2 3 4 5 6 ]; };
      };

      "hyprland/window" = {
        format = "{class}";
        icon = true;
        icon-size = 15;
      };

      cava = {
        hide_on_silence = true;
        framerate = 60;
        bars = 8;
        format-icons = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
        input_delay = 1;
        sleep_timer = 5;
        bar_delimiter = 0;
        on-click = "playerctl play-pause";
      };

      "group/misc" = {
        orientation = "horizontal";
        modules = [ "clock" "custom/lyric" ];
      };

      clock = {
        format = "󰥔  {:%H:%M}";
        format-alt = "󰃭  {:%Y-%m-%d %A}";
        locale = "C";
        tooltip-format = ''
          <big>{:%Y %B}</big>
          <tt><small><span font='JetbrainsMono Nerd Font'>{calendar}</span></small></tt>'';
        calendar = {
          mode = "month";
          mode-mon-col = 3;
          weeks-pos = "right";
          format = {
            months = "<span color='#f5e0dc'><b>{}</b></span>";
            days = "<span color='#f5c2e7'><b>{}</b></span>";
            weeks = "<span color='#94e2d5'><b>W{}</b></span>";
            weekdays = "<span color='#f9e2af'><b>{}</b></span>";
            today = "<span color='#f38ba8'><b><u>{}</u></b></span>";
          };
        };
        actions.on-click-right = "mode";
        interval = 1;
        timezone = "Asia/Taipei";
      };

      "custom/lyric" = {
        exec = "playerctl metadata --format='{{ title }}' --follow";
        format = "󰎆  {}";
        tooltip-format = "Play/Pause";
        on-click = "playerctl play-pause";
        escape = true;
        return-type = "text";
        max-length = 25;
      };

      "group/monitor" = {
        orientation = "horizontal";
        modules = [ "cpu" "memory" "backlight" "pulseaudio" ];
      };

      cpu = {
        interval = 10;
        format = "  {usage}";
      };

      memory = {
        interval = 30;
        format = "  {percentage}";
        max-length = 10;
      };

      backlight = {
        format = "{icon} {percent}";
        format-icons = [ " " " " " " " " " " " " " " " " " " ];
      };

      pulseaudio = {
        format = "{icon} {volume}";
        format-bluetooth = "  {volume}";
        format-muted = " ";
        format-icons.default = [ "" " " " " ];
        on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
      };

      "group/connection" = {
        orientation = "horizontal";
        modules = [ "network" "bluetooth" ];
      };

      network = {
        interface = "wlo1";
        format = "{icon}";
        format-icons = {
          wifi = [ "󰤯 " "󰤟 " "󰤢 " "󰤥 " "󰤨 " ];
          ethernet = [ "󰈀 " ];
          disconnected = [ "󰤭 " ];
        };
        tooltip-format-wifi = "{essid} ({signalStrength}%)";
        tooltip-format-ethernet = "{ifname}";
        tooltip-format-disconnected = "Disconnected";
      };

      bluetooth = {
        format = "";
        format-disabled = "󰂲";
        format-connected = "󰂱";
        tooltip-format = "{controller_alias}";
        tooltip-format-connected = "{device_enumerate}";
        tooltip-format-off = "Off";
        tooltip-format-disabled = "Off";
        tooltip-format-enumerate-connected =
          "{device_alias}	{device_battery_percentage}%";
      };

      "group/quick" = {
        orientation = "inherit";
        drawer = {
          transition-duration = 300;
          transition-left-to-right = false;
        };
        modules = [ "custom/hexecute" "tray" ];
      };

      tray = {
        icon-size = 15;
        spacing = 6;
      };

      "group/power" = {
        orientation = "inherit";
        modules = [ "idle_inhibitor" "battery" ];
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = " ";
          deactivated = "󰤄";
        };
      };

      battery = {
        interval = 60;
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}";
        format-icons = [ "󰁺" "󰁻" "󰁼" "󰁾" "󰁿" "󰂀" "󰂁" "󰂁" "󰂂" "󰁹" ];
        on-click = "swaync-client -t";
      };

      "custom/hexecute" = {
        format = " ";
        tooltip-format = "魔法使い";
        on-click = "hexecute";
      };
    };
  };
}
