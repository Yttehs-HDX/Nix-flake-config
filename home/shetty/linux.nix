{ pkgs, ... }:

{
  services = {
    gnome-keyring.enable = true;
    network-manager-applet.enable = true;
    blueman-applet.enable = true;
    udiskie.enable = true;
    kdeconnect = {
      enable = true;
      indicator = true;
    };
    syncthing.enable = true;
    ollama.enable = true;
  };

  programs.onlyoffice = {
    enable = true;
    settings = {
      UITheme = "theme-night";
      editorWindowMode = false;
      locale = "zh-CN";
    };
  };
}
