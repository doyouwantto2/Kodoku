{ config, pkgs, lib, xdg, ... }:

{
  home.file."cava".source = config.lib.file.mkOutOfStoreSymlink "./extra/dotfiles/cava";
  home.file."hypr".source = config.lib.file.mkOutOfStoreSymlink "./extra/dotfiles/hypr";
}
