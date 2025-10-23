{ config, pkgs, ... }:

{
  imports = [
    ./init/init.nix

    ./base/configuration.nix

    ./development/development.nix

    ./security/security.nix

    ./desktop/desktop.nix
  ];
}
