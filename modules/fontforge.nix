{ pkgs, ... }:
{
  config.environment.systemPackages = with pkgs; [
    fontforge
    fontforge-gtk
  ];
}
