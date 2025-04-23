{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.local = {
    wm = lib.mkOption {
      description = "The default window manager for the server";
      type = lib.types.str;
      default = "twm";
    };
  };

  config = {
    virtualisation.vmVariant.virtualisation.graphics = lib.mkForce true;
    #boot.plymouth.enable = true;
    #boot.plymouth.theme = "bgrt"; # or "spinfinity", "fade-in", etc.

    environment.systemPackages = with pkgs; [
      bemenu
      alacritty
    ];

    services.libinput.touchpad.naturalScrolling = config.local.withNaturalScrolling;
    services.displayManager = {
      enable = true;
      autoLogin = {
        enable = true;
        user = config.local.userName;
      };
      defaultSession = "none+${config.local.wm}";
    };
    services.xserver = {
      enable = true;
      xkb = {
        layout = if config.local.withNaturalKeyboard then "de" else "us";
        options = if config.local.withNaturalKeyboard then "" else "ctrl:nocaps";
      };
      resolutions = [
        {
          x = 1600;
          y = 1200;
        }
        {
          x = 1280;
          y = 720;
        }
      ];
      windowManager."${config.local.wm}".enable = true;
      displayManager.lightdm.enable = true;
    };

    hardware.graphics.enable = true; # when using QEMU KVM

    system.userActivationScripts.setupDesktop =
      ''
        cp --symbolic-link --update ${./xprofile} ~/.xprofile
        cp --symbolic-link --update ${./xresources} ~/.Xresources
      ''
      + lib.optionalString (config.local.wm == "twm") ''
        cp --symbolic-link --update ${./twmrc} ~/.twmrc
      '';
  };
}
