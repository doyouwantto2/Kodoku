{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bat

    eza

    zoxide

    cava

    hyprshot

    dmidecode

    btop
  ];
}

