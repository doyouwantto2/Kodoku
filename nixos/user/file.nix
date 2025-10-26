{ config, pkgs, ... }:

{
  home.file = {
    ".config/cava".source = config.lib.file.mkOutOfStoreSymlink ./extra/dotfiles/cava;
    ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink ./extra/dotfiles/hypr;
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink ./extra/dotfiles/nvim;
  };
}
