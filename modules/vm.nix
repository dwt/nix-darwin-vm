{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  darwinArch = lib.replaceStrings [ "linux" ] [ "darwin" ] pkgs.system;
  darwinPkgs = inputs.nixpkgs.legacyPackages.${darwinArch};
in
{
  # Make VM output to the terminal instead of a separate window
  virtualisation.vmVariant.virtualisation.graphics = false;
  virtualisation.vmVariant.virtualisation.host.pkgs = darwinPkgs;
}
