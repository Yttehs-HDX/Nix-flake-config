{ lib, current }:
lib.mapAttrs (relationId: instance:
  let
    platformSystem = instance.host.platform.system;
    isDarwinPlatform = platformSystem != null
      && lib.hasSuffix "-darwin" platformSystem;

    username = if instance.relation.identity.name != null then
      instance.relation.identity.name
    else
      lib.toLower instance.userId;

    homeDirectory = if instance.relation.identity.homeDirectory != null then
      instance.relation.identity.homeDirectory
    else if isDarwinPlatform then
      "/Users/${username}"
    else
      "/home/${username}";
  in {
    inherit relationId homeDirectory;
    hostId = instance.hostId;
    userId = instance.userId;
    backend = instance.backend;
    scopes = instance.scopes;
    current = instance;

    identity = {
      name = username;
      uid = instance.relation.identity.uid;
      inherit homeDirectory;
    };

    account = { initialHashedPassword = instance.user.initialHashedPassword; };

    membership = {
      primaryGroup = instance.relation.membership.primaryGroup;
      extraGroups = instance.relation.membership.extraGroups;
    };

    state = {
      home = { stateVersion = instance.relation.state.home.stateVersion; };
    };

    packages = instance.packages;
    unsupportedPackages = instance.unsupportedPackages;
    theme = instance.theme;
  }) current
