{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
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
      lix-module,
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
