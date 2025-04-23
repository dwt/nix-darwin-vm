{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  matchingDarwinArch = lib.replaceStrings [ "linux" ] [ "darwin" ] pkgs.system;
  darwinPkgs = inputs.nixpkgs.legacyPackages.${matchingDarwinArch};
in
{
  config.virtualisation.vmVariant.virtualisation = {
    # Make VM output to the terminal instead of a separate window
    graphics = false;
    # Allow the VM to start on darwin
    host.pkgs = darwinPkgs;
  };
}
