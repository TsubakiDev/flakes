{
  pkgs,
  lib,
  config,
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
    nswitch = "sudo bash -c 'nixos-rebuild switch |& nom'";
    nfu = "sudo nix flake update";
    g = "git";
  };

  home.packages = with pkgs; [
    nix-output-monitor
    fastfetch
    nixfmt-rfc-style
    bitwarden-desktop
    wpsoffice-cn
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
  ];

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-material-color
      fcitx5-mozc
      fcitx5-gtk
    ];
  };

  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
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
