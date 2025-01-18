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
    in
    {
      homeManagerModule = import ./modules/home-manager;
      animeGamesLauncherModule = import ./modules/anime-games-launcher;

      nixosConfigurations = {
        # My personal notebook
        firefly = nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/firefly ];

          specialArgs = {
            inherit inputs outputs;
          };
        };

        # Hanser's fans minecraft server
        mgtown = nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/mgtown ];
        };
      };
    };
}
