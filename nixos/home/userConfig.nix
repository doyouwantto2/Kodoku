{ config, pkgs, ... }:

{
  programs = {
    fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting 
      '';

      plugins = [
        { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      ];
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
