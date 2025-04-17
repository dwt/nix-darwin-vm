{
  hostName,
  userName,
  userPass,
  userShell,
  pkgs,
  lib,
  ...
}:
{
  system.stateVersion = "24.11";

  # Configure networking
  networking = {
    useDHCP = false;
    interfaces.eth0.useDHCP = true;
    hostName = hostName;
  };

  # Create user
  services.getty.autologinUser = userName;
  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Put user in wheel group to…
    password = userPass;
    shell = pkgs."${userShell}";
  };
  # … enable passwordless ‘sudo’ for user
  security.sudo.wheelNeedsPassword = false;
  # doing this the hard way, because
  # programs.bash.enable = true; raises an error
  programs.zsh.enable = ("zsh" == userShell);
  programs.fish.enable = ("fish" == userShell);

  nix.settings.experimental-features = "nix-command flakes";
}
