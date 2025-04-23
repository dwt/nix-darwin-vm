{ pkgs, ... }:
{
  imports = [
    # Import your xserver specific modules here
  ];

  config.environment.systemPackages = with pkgs; [
    # Add your xserver specific packages here
  ];
}
