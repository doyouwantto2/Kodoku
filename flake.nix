{
  description = "A clean, basic flake configuration for NixOS and Home Manager.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.astal.follows = "astal";
    };
  };

  outputs = { self, nixpkgs, home-manager, fenix, ags, astal, ... }@inputs: # All inputs listed here

    let
      user = {
        name = "emiya2467";
        system = "x86_64-linux";
      };

      pkgs = import nixpkgs {
        inherit (user) system;
        overlays = [ fenix.overlays.default ];
      };

      rustPkgs = fenix.packages.${user.system}.stable;
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = user.system;
        modules = [
          ./nixos/system/zone.nix
        ];
        specialArgs = {
          inherit user rustPkgs ags astal inputs;
        };
      };

      homeConfigurations.${user.name} = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        modules = [
          ./nixos/user/user.nix
        ];
        extraSpecialArgs = {
          inherit user inputs;
        };
      };
    };
}
