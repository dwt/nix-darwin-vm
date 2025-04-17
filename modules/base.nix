{
  hostName,
  userName,
  userPass,
  userShell,
  pkgs,
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
  programs."${userShell}".enable = true;

  system.userActivationScripts.setupShell = pkgs.lib.optionalString (userShell == "zsh") ''
    touch ~/.zshrc
  '';

  nix.settings.experimental-features = "nix-command flakes";
}
