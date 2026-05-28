{ pkgs, ... }:

{
  users.users.shetty = {
    isNormalUser = true;
    description = "Shetty";
    initialHashedPassword = "$y$j9T$IbyB4U5AIUqcxol3JR60E0$/Wr3iDHuKpYBX7lkBSMJHGWlRS3quNv.DqQvkpKK4dD";

    shell = pkgs.zsh;

    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "adbusers"
      "libvirtd"
      "wireshark"
      "video"
      "audio"
      "uucp"
      "dialout"
    ];
  };
}
