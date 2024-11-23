{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.username = "tsubaki";
  home.homeDirectory = "/home/tsubaki";
  home.stateVersion = "24.05";

  home.sessionVariables = {
    EDITOR = "nvim";
    MOZ_USE_XINPUT2 = "1";
  };

  home.shellAliases = {
    # System
    nswitch = "sudo bash -c 'nixos-rebuild switch |& nom'";
    nfu = "sudo nix flake update";

    # Git
    gcwm = "git commit -m";
    gpush = "git push";
    gpull = "git pull";
    grebase = "git rebase";
  };

  home.packages = with pkgs; [
    # Tools
    nix-output-monitor
    fastfetch
    nixfmt-rfc-style

    # Utility Softwares
    bitwarden-desktop
    clash-verge-rev
    libreoffice-fresh
    yubikey-manager-qt

    # Media
    vlc
    cider

    # Programming Languages
    rustup
    go

    # IM
    telegram-desktop

    # Games
    osu-lazer-bin
  ];

  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };

    firefox = {
      enable = true;
    };

    neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [ vim-nix ];
    };

    git = {
      enable = true;
      userName = "TsubakiDev";
      userEmail = "i@tsubakidev.cc";
    };

    fish = {
      enable = true;
    };

    wezterm = {
      enable = true;
    };

    home-manager = {
      enable = true;
    };
  };
}
