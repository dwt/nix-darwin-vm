{
  config,
  ...
}:
let
  logout = {
    bash = ".bash_logout";
    zsh = ".zlogout";
  }."${config.local.userShell}" or (throw "autoShutdownOnLogout not supported for ${config.local.userShell}");
in
{
  config.system.userActivationScripts.autoShutdown = ''
    echo "sudo poweroff" > ~/${logout}
  '';
}
