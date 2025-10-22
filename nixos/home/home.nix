{ config, pkgs, ... }:

{
  imports = [
    ./bridge.nix
    ./config.nix
  ];

  home.username = "emiya2467";
  home.homeDirectory = "/home/emiya2467";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
