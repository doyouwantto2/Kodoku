{ config, pkgs, hyprland, ... }@inputs:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    plugins = [
    ];

    extraConfig = ''
      source = ${config.xdg.configHome}/hypr/hyprland.conf
    '';
  };
}
