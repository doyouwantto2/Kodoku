{ config, pkgs, ... }:

{
  imports = [
    ./init/configuration.nix

    ./setup/setup.nix

    ./development/development.nix

    ./security/security.nix

    ./workspace/workspace.nix
  ];
}
