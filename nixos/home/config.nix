{ config, pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [
          "git"
          "z"
        ];
      };
    };

    git = {
      enable = true;
      settings.user = {
        name = "doyouwantto2";
        email = "tinhphong2580@gmail.com";
      };
    };
  };
}
