{ config, pkgs, ... }:

{
  programs.nix-ld.enable = true;
  programs.xwayland.enable = true;

  environment.systemPackages = with pkgs; [
    git
    wezterm
    kitty
    wl-clipboard
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    openssl
    pkg-config
    glib
    gobject-introspection
    gtk3
    gtk4
    libiconv
  ];
}
