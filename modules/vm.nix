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
  # Make VM output to the terminal instead of a separate window
  virtualisation.vmVariant.virtualisation.graphics = false;
  # Allow the VM to start on darwin
  virtualisation.vmVariant.virtualisation.host.pkgs = darwinPkgs;
}
