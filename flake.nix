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
      home-manager,
      nixpkgs,
      aagl,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.nixos-itx-3400G = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./machine/nixos-itx-3400G/configuration.nix
          ./machine/nixos-itx-3400G/hardware.nix
          home-manager.nixosModules.home-manager
          { home-manager.users.tsubaki = import ./users/tsubaki/home.nix; }

          {
            imports = [ aagl.nixosModules.default ];
            nix.settings = aagl.nixConfig;

            programs.anime-game-launcher.enable = true;
            programs.honkers-railway-launcher.enable = true;
          }
        ];
      };

      nixosConfigurations.mgtown = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./machine/mgtown/configuration.nix
          ./machine/mgtown/hardware.nix
        ];
      };
    };
}
