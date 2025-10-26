{ config, pkgs, inputs, ... }:

{
  # 1. Define the Home Manager module for Hyprland configuration
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;

    plugins = [
    ];

    extraConfig = ''
      source = ${config.xdg.configHome}/hypr/hyprland.conf
    '';
  };
}
