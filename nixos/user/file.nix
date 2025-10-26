{ config, pkgs, ... }:

{
  home.file = {
    "${config.xdg.configHome}/nvim".source = config.lib.file.mkOutOfStoreSymlink ./extra/dotfiles/nvim;
    "${config.xdg.configHome}/cava".source = config.lib.file.mkOutOfStoreSymlink ./extra/dotfiles/cava;

    "${config.xdg.configHome}/hypr".source = config.lib.file.mkOutOfStoreSymlink ./extra/dotfiles/hypr;
  };
}
