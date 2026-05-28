{ ... }:

{
  networking.firewall.enable = false;
  networking.networkmanager.enable = true;

  networking.extraHosts = ''
    127.0.0.1 localhost
    ::1 localhost
    127.0.0.1 Shetty-Laptop.local
  '';
}
