{
  description = "Tsubaki's nixos settings collection";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    aagl.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    nix-on-droid.url = "github:nix-community/nix-on-droid/release-24.05";
    nix-on-droid.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      aagl,
      flake-utils,
      ...
    }@inputs:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system: {
    })
    // {
      nixosConfigurations =
        let
          mkHost =
            hostName: extraModules:
            nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              modules = [ (./hosts + "/${hostName}") ] ++ extraModules;
              specialArgs = { inherit inputs; };
            };
        in
        {
          hyacine = mkHost "hyacine" [
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.tsubaki = import ./users/tsubaki;
              };
            }
            {
              imports = [ aagl.nixosModules.default ];
              nix.settings = aagl.nixConfig;
              programs.honkers-railway-launcher.enable = true;
            }
          ];

          nixOnDroidConfigurations = {
            castorice = nix-on-droid.lib.nixOnDroidConfiguration {
              system = "aarch64-linux";
              modules = [
                ./hosts/castorice
                home-manager.darwinModules.home-manager
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.tsubaki = import ./users/tsubaki/android.nix;
                  };
                }
              ];
              specialArgs = { inherit inputs; };
              pkgs = import nixpkgs { system = "aarch64-linux"; };
            };
          };

          mgtown = mkHost "mgtown" [ ];
        };
    };
}
