{
  pkgs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "tsubaki";
    homeDirectory = "/home/tsubaki";
    stateVersion = "25.05";

    sessionVariables = {
      EDITOR = "nvim";
      MOZ_USE_XINPUT2 = "1";
      XMODIFIERS = "@im=fcitx";
    };

    shellAliases = {
      updateFlake = "sudo nix flake update";
      nswitch = "sudo bash -c 'nixos-rebuild switch |& nom'";
    };
  };

  home.packages = with pkgs; [
    nix-output-monitor
    fastfetch
    nixfmt-rfc-style
    supergfxctl-plasmoid
    clash-verge-rev
    bitwarden-desktop
    thunderbird
    yubikey-manager-qt
    zenith
    yazi
    cider
    vlc
    rustup
    nodejs_23
    obs-studio
    telegram-desktop
    qq
    element-desktop
    gdlauncher-carbon
    osu-lazer-bin
    wezterm
    google-chrome
  ];

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
      userEmail = "i@tsubaki.dev";
    };

    fish = {
      enable = true;
    };

    home-manager = {
      enable = true;
    };
  };
}
