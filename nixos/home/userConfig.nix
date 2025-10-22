{ config, pkgs, ... }:

{
  programs = {
    bash = {
      enable = true;
      shellAliases = { };

      initExtra = ''
        eval "$(starship init bash)"
        eval "$(fzf --bash)"
        eval "$(zoxide init bash)"
      '';
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
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
