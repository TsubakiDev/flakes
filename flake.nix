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
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      home-manager,
      nixpkgs,
      aagl,
      lix-module,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      homeManagerModule = import ./home;
    in
    {
      nixosConfigurations = {
        # My personal notebook
        firefly = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/firefly

            home-manager.nixosModules.home-manager
            {
              home-manager.users.tsubaki = homeManagerModule;
            }

            {
              imports = [ aagl.nixosModules.default ];
              nix.settings = aagl.nixConfig;

              programs.anime-game-launcher.enable = true;
              programs.honkers-railway-launcher.enable = true;
            }

            lix-module.nixosModules.default
          ];

          specialArgs = {
            inherit inputs;
          };
        };

        # iTX host
        sparkle = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/sparkle

            home-manager.nixosModules.home-manager
            {
              home-manager.users.tsubaki = homeManagerModule;
            }

            {
              imports = [ aagl.nixosModules.default ];
              nix.settings = aagl.nixConfig;

              programs.anime-game-launcher.enable = true;
              programs.honkers-railway-launcher.enable = true;
            }

            lix-module.nixosModules.default
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
