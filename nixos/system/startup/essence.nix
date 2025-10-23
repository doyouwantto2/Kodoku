{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
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
    glibc
    gobject-introspection
    gtk3
    gtk4
    libiconv
  ];
}
