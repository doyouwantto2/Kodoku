{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rofi
    discord
    libreoffice
  ];
}
