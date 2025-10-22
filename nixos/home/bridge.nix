{ config, pkgs, ... }:

{
  home.file = {
    "cava".source = config.lib.file.mkOutOfStoreSymlink ./extra/dotfiles/cava;
    "hypr".source = config.lib.file.mkOutOfStoreSymlink ./extra/dotfiles/hypr;
  };
}
