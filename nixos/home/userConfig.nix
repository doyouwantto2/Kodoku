{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    fishPlugins.grc
  ];

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

    programs.bash = {
      enable = true;
      shellAliases = { };

      initExtra = ''
        eval "$(starship init bash)"
        eval "$(fzf --bash)"
        eval "$(zoxide init bash)"
      '';
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
