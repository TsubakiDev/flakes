{
  description = "Tsubaki's nixos settings collection";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };
  outputs =
    {
      self,
      home-manager,
      nixpkgs,
      sops-nix,
      vscode-server,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        # Hanser's fans minecraft server
        mgtown = nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/mgtown ];
        };

        # Home Lab
        yggdrasil = nixpkgs.lib.nixosSystem {
          vscode-server.nixosModules.default
          modules = [ ./hosts/yggdrasil ];
          inherit self inputs;
        }
      };
    };
}
