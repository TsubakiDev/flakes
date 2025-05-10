{
  description = "Tsubaki's nixos settings collection";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    aagl.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      aagl,
      flake-utils,
      vscode-server,
      ...
    }@inputs:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system: {
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

          castorice = mkHost "castorice" [
            vscode-server.nixosModules.default
            ({ config, pkgs, ... }: {
              services.vscode-server.enable = true;
            })
          ];
          
          mgtown = mkHost "mgtown" [ ];
        };
    };
}
