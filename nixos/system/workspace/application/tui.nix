{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brightnessctl

    bat

    eza

    lazygit

    imagemagick

    ghostscript

    fzf

    ripgrep

    fd

    tree-sitter
  ];
}

