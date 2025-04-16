{
  lib,
  pkgs,
  withNaturalScrolling,
  withNaturalKeyboard,
  userName,
  ...
}:
{
  virtualisation.vmVariant.virtualisation.graphics = lib.mkForce true;
  #boot.plymouth.enable = true;
  #boot.plymouth.theme = "bgrt"; # or "spinfinity", "fade-in", etc.

  environment.systemPackages = with pkgs; [
    swaybg
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
  };

  security.polkit.enable = true;
  hardware.graphics.enable = true; # when using QEMU KVM

  # TODO: replace greetd with emptty?
  services.greetd = {
    enable = true;
    settings = rec {
      default_session = {
        command =
          with pkgs;
          lib.concatStringsSep " " [
            "${lib.getBin greetd.greetd}/bin/agreety"
            "--cmd '${initial_session.command}'"
          ];
      };
      initial_session = {
        user = userName;
        command =
          with pkgs;
          lib.concatStringsSep " " [
            "${lib.getExe labwc}"
            "-s"
            "${lib.getExe alacritty}"
          ];
      };
    };
  };
  # Starts weston, but terminals exit
  #environment.loginShellInit = with pkgs; ''
  #  [[ "$(tty)" == /dev/tty1 ]] && ${nixpkgs.lib.getBin weston}/bin/weston
  #'';

  system.userActivationScripts.setupDesktop =
    let
      envFile = "~/.config/labwc/environment";
    in
    ''
      mkdir -p ~/.config/labwc
      cp --symbolic-link --update ${./menu.xml} ~/.config/labwc/menu.xml
      cp --symbolic-link --update ${./autostart} ~/.config/labwc/autostart
      cat ${./xkbMacKeyboardConfig} > ${envFile}
    ''
    + lib.optionalString withNaturalKeyboard ''
      echo XKB_DEFAULT_LAYOUT=de >> ${envFile}
    '';
}
