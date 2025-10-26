{ config, pkgs, inputs, ... }:

{
  nixpkgs.overlays = [
    inputs.self.overlays.hypr-flake-override
  ];

  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
}
