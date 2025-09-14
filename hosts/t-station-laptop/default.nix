{ pkgs, ... }:
{
  imports = [
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "tsubaki";

  networking.hostName = "t-station-laptop";

  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;
  programs.gnupg.agent.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    rustup
    zenith
    fastfetch
    git
    gcc
    ollama-cuda
    zola
    nix-output-monitor
    nixfmt-rfc-style
    zulu
  ];

  nix = {
    package = pkgs.lix;

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ 
        "https://mirror.iscas.ac.cn/nix-channels/store"
        "https://cache.nixos.org"
      ];
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
  };

  system.stateVersion = "25.05";
}