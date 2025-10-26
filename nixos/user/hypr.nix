{ config, pkgs, inputs, ... }:

let
  hyprspaceDerivation = inputs.Hyprspace.packages.${pkgs.system}.Hyprspace;

  Hyprspace = hyprspaceDerivation.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ pkgs.cmake pkgs.pkg-config ];

    buildInputs = (oldAttrs.buildInputs or [ ]) ++ [ inputs.hyprland.packages.${pkgs.system}.hyprland ];

    postInstall = ''
      # Assuming the plugin is built as a .so file in the current directory
      mkdir -p $out/lib
      find . -name "*.so" -exec cp {} $out/lib/ \;
    '';
  });

in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    plugins = [
      Hyprspace # Use the overridden package
    ];

    extraConfig = ''
      source = ${config.xdg.configHome}/hypr/hyprland.conf
    '';
  };
}
