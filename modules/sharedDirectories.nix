{ userName, ... }:
{
  # cannot modify files from inside the vm, the permissions make it effectively read only
  virtualisation.vmVariant.virtualisation.sharedDirectories = {
    modules = {
      source = "${../shared}";
      target = "/home/${userName}/shared";
      securityModel = "none";
    };
  };
}
