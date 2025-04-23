{ pkgs, ... }:
{
  imports = [
    # Import your wayland specific modules here
  ];

  config.environment.systemPackages = with pkgs; [
    # Add your wayland specific packages here
  ];
}
