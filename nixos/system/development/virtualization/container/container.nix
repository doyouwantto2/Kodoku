{ config, pkgs, ... }:

{
  imports = [
    ./cloud.nix
    ./docker.nix
  ];
}
