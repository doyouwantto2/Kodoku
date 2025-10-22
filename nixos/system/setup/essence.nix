{ config, pkgs, ... }:

{
  programs.hyprland.enable = true;
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    wezterm
    kitty
    wl-clipboard
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    openssl
    pkg-config
    libiconv
  ];
}
