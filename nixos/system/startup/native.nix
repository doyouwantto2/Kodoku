{ config, pkgs, lib, ... }:

{
  fonts.packages = [
  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  xdg.portal.wlr.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  environment.sessionVariables = {
    OPENSSL_DIR = "${pkgs.openssl.dev}";
    OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
    OPENSSL_INCLUDE_DIR = "${pkgs.openssl.dev}/include";
    PKG_CONFIG_PATH = "${pkgs.gtk3.dev}/lib/pkgconfig:${pkgs.glib.dev}/lib/pkgconfig:${pkgs.gobject-introspection.dev}/lib/pkgconfig:${pkgs.openssl.dev}/lib/pkgconfig";
  };
}
