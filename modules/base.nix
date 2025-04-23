{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    hostName = lib.mkOption {
      description = "The name for the server";
      type = lib.types.str;
      default = "lix";
    };
    userName = lib.mkOption {
      description = "The name for the default user";
      type = lib.types.str;
      default = "obe";
    };
    userPass = lib.mkOption {
      description = "The password for the default user";
      type = lib.types.str;
      default = "lix";
    };
    userShell = lib.mkOption {
      description = "The shell for the default user";
      type = lib.types.str;
      default = "zsh";
    };
  };

  config = {
    system.stateVersion = "24.11";

    # Configure networking
    networking = {
      useDHCP = false;
      interfaces.eth0.useDHCP = true;
      hostName = config.hostName;
    };

    # Create user
    services.getty.autologinUser = config.userName;
    users.users.${config.userName} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Put user in wheel group to…
      password = config.userPass;
      shell = pkgs."${config.userShell}";
    };
    # … enable passwordless ‘sudo’ for user
    security.sudo.wheelNeedsPassword = false;
    # doing this the hard way, because
    # programs.bash.enable = true; raises an error
    programs.zsh.enable = ("zsh" == config.userShell);
    programs.fish.enable = ("fish" == config.userShell);

    # suppress noisy startup menu when ~/.zshrc is missing
    system.userActivationScripts.setupShell = pkgs.lib.optionalString (config.userShell == "zsh") ''
      touch ~/.zshrc
    '';

    nix.settings.experimental-features = "nix-command flakes";
  };
}
