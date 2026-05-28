{ config, ... }:

{
  networking.extraHosts = ''
    127.0.0.1 localhost
    ::1 localhost
    127.0.0.1 ${config.networking.hostName}.local
  '';
}
