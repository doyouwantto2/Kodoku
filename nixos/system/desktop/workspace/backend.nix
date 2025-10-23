{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    hyprland-protocols
  ];
}

