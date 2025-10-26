{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lazygit

    imagemagick

    ghostscript

    fzf

    ripgrep

    fd

    tree-sitter
  ];
}

