{ config, pkgs, ... }:
{
  imports = [
    ./user/sound.nix
  ];

  config = {
    virtualisation.vmVariant.virtualisation = {
      qemu.options = [
        "-audio driver=coreaudio,model=virtio"
      ];
    };
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    users.extraUsers."${config.local.userName}".extraGroups = [ "audio" ];
    environment.systemPackages = with pkgs; [
      sox
      mpv
    ];
  };
}
