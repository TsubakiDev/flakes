{ ... }:
{
  programs.fish.enable = true;
  programs.gnupg.agent.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    rustup
    zenith
    nvtop
    fastfetch
    gcc
    ollama-cuda
    zola
    nix-output-monitor
    nixfmt-rfc-style
    graalvmPackages.graalvm-ce
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