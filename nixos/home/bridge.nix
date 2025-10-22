{ config, pkgs, lib, ... }:

{
  home.file = {
    ".config/cava".source = lib.file.mkOutOfStoreSymlink ./extra/dotfiles/cava;
  };
}
