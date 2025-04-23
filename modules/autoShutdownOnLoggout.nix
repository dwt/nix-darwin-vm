{
  config,
  ...
}:
let
  logout = {
    bash = ".bash_logout";
    zsh = ".zlogout";
  }."${config.userShell}" or (throw "autoShutdownOnLogout not supported for ${config.userShell}");
in
{
  config.system.userActivationScripts.autoShutdown = ''
    echo "sudo poweroff" > ~/${logout}
  '';
}
