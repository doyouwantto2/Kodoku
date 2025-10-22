{ config, pkgs, lib, ... }:

{
  home.file = {
    ".config/cava".source = lib.mkOutOfStoreSymlink ./extra/dotfiles/cava;
  };
}
