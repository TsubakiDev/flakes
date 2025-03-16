{
  description = "Tsubaki's nixos settings collection";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, aagl, flake-utils, ... }@inputs:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system: {
    }) // {
      nixosConfigurations = let
        mkHost = hostName: extraModules: nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ (./hosts + "/${hostName}") ] ++ extraModules;
          specialArgs = { inherit inputs; };
        };
      in {
        chronara = mkHost "chronara" [
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.tsubaki = import ./home/tsubaki;
            };
          }
          aagl.nixosModules.default
          {
            nix.settings = aagl.nixConfig;
            programs.anime-game-launcher.enable = true;
            programs.honkers-railway-launcher.enable = true;
          }
        ];

        hyacine = mkHost "hyacine" [
          chronara = mkHost "chronara" [
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.tsubaki = import ./home/tsubaki;
            };
          }
          aagl.nixosModules.default
          {
            nix.settings = aagl.nixConfig;
            programs.anime-game-launcher.enable = true;
            programs.honkers-railway-launcher.enable = true;
          }
        ];
        ];

        mgtown = mkHost "mgtown" [];
        cloudvalley = mkHost "cloudvalley" [];
      };
    };
}