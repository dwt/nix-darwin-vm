{
  userShell,
  ...
}:
let
  logout = {
    bash = ".bash_logout";
    zsh = ".zlogout";
  }."${userShell}" or (throw "autoShutdownOnLogout not supported for ${userShell}");
in
{
  system.userActivationScripts.autoShutdown = ''
    echo "sudo poweroff" > ~/${logout}
  '';
}
