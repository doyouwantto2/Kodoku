{ config, pkgs, ... }:

{
  imports = [
    ./file.nix
    ./hypr.nix
    ./tool.nix
  ];

  home.username = "emiya2467";
  home.homeDirectory = "/home/emiya2467";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
