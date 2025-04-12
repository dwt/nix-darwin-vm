{
  system.userActivationScripts.autoShutdown = ''
    echo "sudo poweroff" > ~/.bash_logout
  '';
}
