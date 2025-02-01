{
  description = "Tsubaki's nixos settings collection";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      home-manager,
      nixpkgs,
      plasma-manager,
      sops-nix,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        # My personal notebook
        firefly = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/firefly
            home-manager.nixosModules.home-manager
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
