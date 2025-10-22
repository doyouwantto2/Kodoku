{ config, pkgs, lib, xdg, ... }:

{
  xdg.configFile."cava".source = config.lib.file.mkOutOfStoreSymlink "./extra/dotfiles/cava";
  xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink "./extra/dotfiles/hypr";
}
