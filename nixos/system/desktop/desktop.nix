{ config, pkgs, ... }:

{
  imports = [
    ./application/application.nix

    ./workspace/workspace.nix
  ];
}
