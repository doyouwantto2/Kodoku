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

    PKG_CONFIG_PATH = lib.makeSearchPath "lib/pkgconfig" [
      pkgs.openssl.dev
      pkgs.openssl
      pkgs.glib
      pkgs.gobject-introspection
      pkgs.gtk3
      pkgs.gtk4
    ];

    LD_LIBRARY_PATH = lib.makeLibraryPath [
      pkgs.gtk3
      pkgs.glib
      pkgs.openssl
    ];
  };
}
