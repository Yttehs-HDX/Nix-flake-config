let
  palette = import ./palette.nix;
in
{
  services.swaync.style = ''
    * {
      all: unset;
      font-size: 14px;
      font-family: "SF Pro";
      transition: 200ms;
    }

    trough highlight {
      background: ${palette.text};
    }

    scale trough {
      margin: 0rem 1rem;
      background-color: ${palette.surface0};
      min-height: 8px;
      min-width: 70px;
    }

    slider {
      background-color: ${palette.blue};
    }

    .floating-notifications.background .notification-row .notification-background {
      box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px ${palette.surface0};
      border-radius: 12.6px;
      margin: 18px;
      background-color: ${palette.base};
      color: ${palette.text};
      padding: 0;
    }

    .floating-notifications.background .notification-row .notification-background .notification {
      padding: 7px;
      border-radius: 12.6px;
    }

    .floating-notifications.background .notification-row .notification-background .notification.critical {
      box-shadow: inset 0 0 7px 0 ${palette.red};
    }

    .floating-notifications.background .notification-row .notification-background .notification .notification-content {
      margin: 7px;
    }

    .floating-notifications.background .notification-row .notification-background .notification .notification-content .summary {
      color: ${palette.text};
    }

    .floating-notifications.background .notification-row .notification-background .notification .notification-content .time {
      color: ${palette.subtext0};
    }

    .floating-notifications.background .notification-row .notification-background .notification .notification-content .body {
      color: ${palette.text};
    }

    .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * {
      min-height: 3.4em;
    }

    .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action {
      border-radius: 7px;
      color: ${palette.text};
      background-color: ${palette.surface0};
      box-shadow: inset 0 0 0 1px ${palette.surface1};
      margin: 7px;
    }

    .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
      box-shadow: inset 0 0 0 1px ${palette.surface1};
      background-color: ${palette.surface0};
      color: ${palette.text};
    }

    .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
      box-shadow: inset 0 0 0 1px ${palette.surface1};
      background-color: ${palette.sapphire};
      color: ${palette.text};
    }

    .floating-notifications.background .notification-row .notification-background .close-button {
      margin: 7px;
      padding: 2px;
      border-radius: 6.3px;
      color: ${palette.base};
      background-color: ${palette.red};
    }

    .floating-notifications.background .notification-row .notification-background .close-button:hover {
      background-color: ${palette.maroon};
      color: ${palette.base};
    }

    .floating-notifications.background .notification-row .notification-background .close-button:active {
      background-color: ${palette.red};
      color: ${palette.base};
    }

    .control-center {
      box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px ${palette.surface0};
      border-radius: 12.6px;
      margin: 18px;
      background-color: ${palette.base};
      color: ${palette.text};
      padding: 14px;
    }

    .widget-title {
      margin-bottom: 5px;
    }

    .control-center .widget-title > label {
      color: ${palette.text};
      font-size: 1.3em;
    }

    .control-center .widget-title button {
      border-radius: 7px;
      color: ${palette.text};
      background-color: ${palette.surface0};
      box-shadow: inset 0 0 0 1px ${palette.surface1};
      padding: 8px;
    }

    .control-center .widget-title button:hover {
      box-shadow: inset 0 0 0 1px ${palette.surface1};
      background-color: ${palette.surface2};
      color: ${palette.text};
    }

    .control-center .widget-title button:active {
      box-shadow: inset 0 0 0 1px ${palette.surface1};
      background-color: ${palette.sapphire};
      color: ${palette.base};
    }

    .control-center .notification-row .notification-background {
      border-radius: 7px;
      color: ${palette.text};
      background-color: ${palette.surface0};
      box-shadow: inset 0 0 0 1px ${palette.surface1};
      margin-top: 14px;
    }

    .control-center .notification-row .notification-background .notification {
      padding: 7px;
      border-radius: 7px;
    }

    .control-center .notification-row .notification-background .notification.critical {
      box-shadow: inset 0 0 7px 0 ${palette.red};
    }

    .control-center .notification-row .notification-background .notification .notification-content {
      margin: 7px;
    }

    .control-center .notification-row .notification-background .notification .notification-content .summary {
      color: ${palette.text};
    }

    .control-center .notification-row .notification-background .notification .notification-content .time {
      color: ${palette.subtext0};
    }

    .control-center .notification-row .notification-background .notification .notification-content .body {
      color: ${palette.text};
    }

    .control-center .notification-row .notification-background .notification > *:last-child > * {
      min-height: 3.4em;
    }

    .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action {
      border-radius: 7px;
      color: ${palette.text};
      background-color: ${palette.crust};
      box-shadow: inset 0 0 0 1px ${palette.surface1};
      margin: 7px;
    }

    .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
      box-shadow: inset 0 0 0 1px ${palette.surface1};
      background-color: ${palette.surface0};
      color: ${palette.text};
    }

    .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
      box-shadow: inset 0 0 0 1px ${palette.surface1};
      background-color: ${palette.sapphire};
      color: ${palette.text};
    }

    .control-center .notification-row .notification-background .close-button {
      margin: 7px;
      padding: 2px;
      border-radius: 6.3px;
      color: ${palette.base};
      background-color: ${palette.maroon};
    }

    .close-button {
      border-radius: 6.3px;
    }

    .control-center .notification-row .notification-background .close-button:hover {
      background-color: ${palette.red};
      color: ${palette.base};
    }

    .control-center .notification-row .notification-background .close-button:active {
      background-color: ${palette.red};
      color: ${palette.base};
    }

    .control-center .notification-row .notification-background:hover {
      box-shadow: inset 0 0 0 1px ${palette.surface1};
      background-color: ${palette.overlay1};
      color: ${palette.text};
    }

    .control-center .notification-row .notification-background:active {
      box-shadow: inset 0 0 0 1px ${palette.surface1};
      background-color: ${palette.sapphire};
      color: ${palette.text};
    }

    .notification.critical progress {
      background-color: ${palette.red};
    }

    .notification.low progress,
    .notification.normal progress {
      background-color: ${palette.blue};
    }

    .control-center-dnd {
      margin-top: 5px;
      border-radius: 8px;
      background: ${palette.surface0};
      border: 1px solid ${palette.surface1};
      box-shadow: none;
    }

    .control-center-dnd:checked {
      background: ${palette.surface0};
    }

    .control-center-dnd slider {
      background: ${palette.surface1};
      border-radius: 8px;
    }

    .widget-dnd {
      margin-bottom: 5px;
      font-size: 1.1rem;
    }

    .widget-dnd > switch {
      font-size: initial;
      border-radius: 8px;
      background: ${palette.surface0};
      border: 1px solid ${palette.surface1};
      box-shadow: none;
    }

    .widget-dnd > switch:checked {
      background: ${palette.surface0};
    }

    .widget-dnd > switch slider {
      background: ${palette.surface1};
      border-radius: 8px;
      border: 1px solid ${palette.overlay0};
    }

    .widget-mpris {
      border-radius: 18px;
      margin-bottom: 5px;
    }

    .widget-mpris .widget-mpris-player {
      background: ${palette.surface0};
      padding: 7px;
      border-radius: 18px;
    }

    .widget-mpris .widget-mpris-title {
      font-size: 1.2rem;
    }

    .widget-mpris .widget-mpris-subtitle {
      font-size: 0.8rem;
    }

    .widget-menubar > box > .menu-button-bar > button > label {
      font-size: 3rem;
      padding: 0.5rem 2rem;
    }

    .widget-menubar > box > .menu-button-bar > :last-child {
      color: ${palette.red};
    }

    .power-buttons button:hover,
    .powermode-buttons button:hover,
    .screenshot-buttons button:hover {
      background: ${palette.surface0};
    }

    .control-center .widget-label > label {
      color: ${palette.text};
      font-size: 2rem;
    }

    .widget-buttons-grid {
      padding-top: 1rem;
    }

    .widget-buttons-grid > flowbox > flowboxchild > button label {
      font-size: 2.5rem;
    }

    .widget-volume {
      padding-top: 1rem;
    }

    .widget-volume label {
      font-size: 1.5rem;
      color: ${palette.sapphire};
    }

    .widget-volume trough highlight {
      background: ${palette.sapphire};
    }

    .widget-backlight trough highlight {
      background: ${palette.yellow};
    }

    .widget-backlight label {
      font-size: 1.5rem;
      color: ${palette.yellow};
    }

    .widget-backlight .KB {
      padding-bottom: 1rem;
    }

    .image {
      padding-right: 0.5rem;
    }
  '';
}
