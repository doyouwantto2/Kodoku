{ config, pkgs, inputs, ... }:

let
  Hyprspace = inputs.Hyprspace.packages.${pkgs.system}.Hyprspace;
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    plugins = [
      Hyprspace
    ];

    extraConfig = "${config.xdg.configHome}/hypr/hyprland.conf";
  };
}
