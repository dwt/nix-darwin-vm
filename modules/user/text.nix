{ pkgs, ... }:
{
  imports = [
    # Import your text specific modules here
  ];

  config.environment.systemPackages = with pkgs; [
    # Add your text specific packages here
  ];
}
