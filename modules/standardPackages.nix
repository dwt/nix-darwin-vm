{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tmux
    zsh
    neovim
    gnused
    silver-searcher
  ];
}
