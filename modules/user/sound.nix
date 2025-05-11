{ pkgs, ... }:
{
  imports = [
    # Import your sound specific modules here
  ];

  config.environment.systemPackages = with pkgs; [
    # Add your sound specific packages here
  ];
}
