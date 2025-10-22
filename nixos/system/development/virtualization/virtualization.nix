{ config, pkgs, ... }:

{
  imports = [
    ./container/container.nix
    ./blockchain/blockchain.nix
  ];
}
