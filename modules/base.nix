{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.local = {
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
      hostName = config.local.hostName;
    };

    # Create user
    services.getty.autologinUser = config.local.userName;
    users.users.${config.local.userName} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Put user in wheel group to…
      password = config.local.userPass;
      shell = pkgs."${config.local.userShell}";
    };
    # … enable passwordless ‘sudo’ for user
    security.sudo.wheelNeedsPassword = false;
    # doing this the hard way, because
    # programs.bash.enable = true; raises an error
    programs.zsh.enable = ("zsh" == config.local.userShell);
    programs.fish.enable = ("fish" == config.local.userShell);

    # suppress noisy startup menu when ~/.zshrc is missing
    system.userActivationScripts.setupShell = pkgs.lib.optionalString (config.local.userShell == "zsh") ''
      touch ~/.zshrc
    '';

    nix.settings.experimental-features = "nix-command flakes";
  };
}
