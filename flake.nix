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
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };
  outputs =
    {
      self,
      flake-utils,
      home-manager,
      aagl,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./system/default.nix
          ./system/laptop/hardware.nix
          home-manager.nixosModules.home-manager
          { home-manager.users.tsubaki = import ./users/tsubaki/home.nix; }
        ];
      };
    };
}
