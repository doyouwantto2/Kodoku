{ config, pkgs, ... }:

{
  imports = [
    ./application/application.nix

    ./frontend/frontend.nix

    ./backend/backend.nix
  ];
}
