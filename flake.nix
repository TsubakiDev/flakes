{
  description = "Tsubaki's nixos settings collection";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      home-manager,
      nixpkgs,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        # Hanser's fans minecraft server
        mgtown = nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/mgtown ];
        };
      };
    };
}
