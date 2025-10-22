{ config, pkgs, ... }:

{
  programs = {
    bash = {
      enable = true;

      shellAliases = {
        systemSync = "sudo nixos-rebuild switch --flake .";
        userSync = "home-manager switch --flake .";
      };


      initExtra = ''
        eval "$(starship init bash)"
        eval "$(fzf --bash)"
        eval "$(zoxide init bash)"
      '';
    };

    zsh = {
      enable = true;

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        systemSync = "sudo nixos-rebuild switch --flake .";
        userSync = "home-manager switch --flake .";
      };

      oh-my-zsh = {
        enable = true;

        plugins = [
          "git"
          "sudo"
          "zoxide"
        ];
      };

      initContent = ''
        eval "$(starship init zsh)"
        eval "$(fzf --zsh)"
        eval "$(zoxide init zsh)"

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
