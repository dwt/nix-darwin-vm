{ config, ... }:
{
  # cannot modify files from inside the vm, the permissions make it effectively read only
  config.virtualisation.vmVariant.virtualisation.sharedDirectories = {
    modules = {
      source = "${../shared}";
      target = "/home/${config.local.userName}/shared";
      securityModel = "none";
    };
  };
}
