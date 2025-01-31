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
    nix-output-monitor fastfetch nixfmt-rfc-style supergfxctl-plasmoid
    bitwarden-desktop thunderbird yubikey-manager-qt
    wireshark zenith yazi
    cider-2 vlc
    rustup go nodejs_23
    obs-studio
    telegram-desktop qq discord
    gdlauncher-carbon
    osu-lazer-bin
  ];

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-material-color
      fcitx5-rime
      fcitx5-mozc
      fcitx5-gtk
    ];
  };

  programs = {
    wezterm = {
      enable = true;
    };

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
