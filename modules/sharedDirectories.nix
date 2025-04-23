{ config, ... }:
{
  # cannot modify files from inside the vm, the permissions make it effectively read only
  config.virtualisation.vmVariant.virtualisation.sharedDirectories = {
    modules = {
      source = "${../shared}";
      target = "/home/${config.userName}/shared";
      securityModel = "none";
    };
  };
}
