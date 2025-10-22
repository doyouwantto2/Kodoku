{ config, pkgs, ... }:

{
  programs = {
    fish = {
      enable = true;
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
