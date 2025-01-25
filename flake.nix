{
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
    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming.url = "github:fufexan/nix-gaming";
  };
  outputs =
    {
      self,
      home-manager,
      nixpkgs,
      aagl,
      ...
    } @inputs:
    let
      system = "x86_64-linux";
      homeManagerModule = import ./modules/home-manager;
    in
    {
      nixosConfigurations = {
        # My personal notebook
        firefly = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/firefly

            home-manager.nixosModules.home-manager {
              home-manager.users.tsubaki = homeManagerModule;
            }

            {
              imports = [ aagl.nixosModules.default ];
              nix.settings = aagl.nixConfig;

              programs.anime-game-launcher.enable = true;
              programs.honkers-railway-launcher.enable = true;
            }
          ];

          specialArgs = {
            inherit inputs;
          };
        };

        # iTX host
        sparkle = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/sparkle

            home-manager.nixosModules.home-manager {
              home-manager.users.tsubaki = homeManagerModule;
            }

            {
              imports = [ aagl.nixosModules.default ];
              nix.settings = aagl.nixConfig;

              programs.anime-game-launcher.enable = true;
              programs.honkers-railway-launcher.enable = true;
            }
          ];

          specialArgs = {
            inherit inputs;
          };
        };

        # Hanser's fans minecraft server
        mgtown = nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/mgtown ];
        };
      };
    };
}
