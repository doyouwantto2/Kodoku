{ config, pkgs, inputs, ... }:

let
  hycovPackage = inputs.hycov.packages.${pkgs.stdenv.hostPlatform.system}.default; # 🌟 Use 'default' or 'hycov' as the package name
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    plugins = [
      hycovPackage
    ];

    extraConfig = "${config.xdg.configHome}/hypr/hyprland.conf";
  };
}
