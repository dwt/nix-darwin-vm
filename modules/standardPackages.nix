{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tmux
    zsh
    neovim
    silver-searcher
  ];
}
