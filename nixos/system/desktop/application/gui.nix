{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rofi
    discord
    slack
    osu-lazer
    libreoffice
    veloren
  ];
}
