{
  lib,
  pkgs,
  withNaturalScrolling,
  withNaturalKeyboard,
  userName,
  wm,
  ...
}:
{
  virtualisation.vmVariant.virtualisation.graphics = lib.mkForce true;
  #boot.plymouth.enable = true;
  #boot.plymouth.theme = "bgrt"; # or "spinfinity", "fade-in", etc.

  environment.systemPackages = with pkgs; [
    bemenu
    alacritty
    # REFACT pull out into it's own module?
    fontforge
    fontforge-gtk
    gnused
  ];

  services.libinput.touchpad.naturalScrolling = withNaturalScrolling;
  services.displayManager = {
    enable = true;
    autoLogin = {
      enable = true;
      user = userName;
    };
    defaultSession = "none+${wm}";
  };
  services.xserver = {
    enable = true;
    xkb = {
      layout = if withNaturalKeyboard then "de" else "us";
      options = if withNaturalKeyboard then "" else "ctrl:nocaps";
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
    windowManager."${wm}".enable = true;
    displayManager.lightdm.enable = true;
  };

  hardware.graphics.enable = true; # when using QEMU KVM

  system.userActivationScripts.setupDesktop =
    ''
      cp --symbolic-link --update ${./xsession} ~/.xsession
    ''
    + lib.optionalString (wm == "twm") ''
      cp --symbolic-link --update ${./twmrc} ~/.twmrc
    '';
}
