{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fontforge
    fontforge-gtk
  ];
}
