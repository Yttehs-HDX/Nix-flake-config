{ input }:
{ lib, config ? { users.mutableUsers = true; }, ... }:
let
  systemPackages = input.packages.system or { };
  homeOnlyPackages = lib.filterAttrs (packageId: _:
    !(builtins.hasAttr packageId systemPackages)
  ) (input.packages.home or { });
  homeOnlyInput = input // {
    packages = input.packages // { home = homeOnlyPackages; };
  };

  packageModules = import ../../common/package-modules.nix {
    inherit lib input;
    backendType = "nixos";
    scope = "system";
  };
  homePackageSystemModules = import ../../common/package-modules.nix {
    inherit lib;
    input = homeOnlyInput;
    backendType = "nixos";
    scope = "home";
    backendScope = "system";
  };
  hasInitialHashedPassword = input.account.initialHashedPassword != null;
  unsupportedWarnings = import ../../common/unsupported-warnings.nix {
    inherit lib input;
    scope = "system";
  };
in {
  imports = packageModules ++ homePackageSystemModules;
  warnings = unsupportedWarnings;

  networking.hostName = input.hostId;
  system.stateVersion = input.current.host.system.stateVersion;
} // lib.optionalAttrs hasInitialHashedPassword {
  users.mutableUsers = lib.mkDefault true;

  assertions = [{
    assertion = config.users.mutableUsers;
    message = ''
      `profile.users.${input.userId}.initialHashedPassword` on host `${input.hostId}`
      requires `users.mutableUsers = true` to preserve first-creation-only semantics.
    '';
  }];
}
