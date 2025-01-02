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
    updateSystem = "sudo nix flake update && sudo bash -c 'nixos-rebuild switch |& nom'";
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
    telegram-desktop
    qq
    osu-lazer-bin
    steam
    gdlauncher-carbon
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
