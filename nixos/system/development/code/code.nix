{ config, pkgs, ... }:

{
  imports = [
    ./editor.nix
    ./language.nix
    ./database.nix
  ];
}
