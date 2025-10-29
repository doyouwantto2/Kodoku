{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rofi
    discord
    slack
    osu-lazer
    tshark
    libreoffice
    veloren
    aircrack-ng
  ];
}
