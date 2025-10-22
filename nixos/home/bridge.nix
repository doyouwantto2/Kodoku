{ config, pkgs, lib, ... }:

{
  home.file = {
    ".config/cava".source = config.lib.file.mkOutOfStoreSymlink ./extra/dotfiles/cava;
  };
}
