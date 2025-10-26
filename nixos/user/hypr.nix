{ config, pkgs, inputs, ... }:

let
  hyprcovPackage = inputs.hyprcov.packages.${pkgs.stdenv.hostPlatform.system}.hyprcov;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    plugins = [
      hyprcovPackage
    ];

    configFile = "${config.xdg.configHome}/hypr/hyprland.conf";
  };
}
