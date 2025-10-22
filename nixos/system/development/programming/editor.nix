{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim

    vscodium

    micro

    fishPlugins.grc
    starship
  ];
}
