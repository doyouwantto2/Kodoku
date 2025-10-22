{ config, pkgs, ... }:

{
  home.file = {
    "cava".source = ./extra/dotfiles/cava;
    "hypr".source = ./extra/dotfiles/hypr;
  };
}
