{
  pkgs,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;

  home.username = "tsubaki";
  home.homeDirectory = "/home/tsubaki";
  home.stateVersion = "25.05";

  home.sessionVariables = {
    EDITOR = "nvim";
    MOZ_USE_XINPUT2 = "1";
    XMODIFIERS = "@im=fcitx";
  };

  home.shellAliases = {
    updateFlake = "sudo nix flake update";
    nswitch = "sudo bash -c 'nixos-rebuild switch |& nom'";
    r = "nixpkgs-review pr";
  };

  home.packages = with pkgs; [
    nix-output-monitor
    fastfetch
    nixfmt-rfc-style
    bitwarden-desktop
    clash-nyanpasu
    proxychains-ng
    yubikey-manager-qt
    wireshark
    vlc
    cider
    rustup
    go
    obs-studio
    telegram-desktop
    jetbrains.idea-community-bin
    osu-lazer-bin
    qq
    steam
    wezterm
    gdlauncher-carbon
    thunderbird
    yazi
    nodejs_23
  ];

  xdg.configFile."wezterm/wezterm.lua".text = ''
      local wezterm = require 'wezterm'
      local config = wezterm.config_builder()
      config.front_end = "WebGpu"
      return config
  '';

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

    home-manager = {
      enable = true;
    };
  };
}
