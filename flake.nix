{
  description = "Tsubaki's nixos settings collection";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    aagl.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    niri.url = "github:sodiboo/niri-flake";
  };

  outputs = { self, nixpkgs, home-manager, aagl, flake-utils, niri, ... }@inputs:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system: {
    }) // {
      nixosConfigurations = let
        mkHost = hostName: extraModules: nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ (./hosts + "/${hostName}") ] ++ extraModules;
          specialArgs = { inherit inputs; };
        };
      in {
        hyacine = mkHost "hyacine" [
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

        mgtown = mkHost "mgtown" [];
        cloudvalley = mkHost "cloudvalley" [];
      };
    };
}