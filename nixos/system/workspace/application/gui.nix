{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rofi
    kando
    gnomeExtensions.kando-integration
  ];
}
