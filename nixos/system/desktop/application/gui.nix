{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rofi
    discord
    slack
    libreoffice
    veloren
  ];
}
