{ config, pkgs, ... }:

{
  imports = [
    ./programming/programming.nix
    ./virtualization/virtualization.nix
  ];
}
