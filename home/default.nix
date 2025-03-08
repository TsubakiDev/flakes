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
      r = "nixpkgs-review pr";
    };
  };

  home.packages = with pkgs; [
    nix-output-monitor
    fastfetch
    nixfmt-rfc-style
    supergfxctl-plasmoid
    bitwarden-desktop
    thunderbird
    yubikey-manager-qt
    wireshark
    zenith
    yazi
    cider-2
    vlc
    rustup
    go
    nodejs_23
    obs-studio
    telegram-desktop
    qq
    discord
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

    plasma = {
      enable = true;

       workspace = {
        clickItemTo = "open";
        lookAndFeel = "org.kde.breezedark.desktop";
        cursor = {
          theme = "Bibata-Modern-Ice";
          size = 32;
        };
        iconTheme = "Papirus-Dark";
        wallpaper = "${NIX_PATH}/static/wallpaper/nix-wallpaper-nineish-catppuccin-macchiato.png";
      };

      hotkeys.commands."launch-wezterm" = {
        name = "Launch Wezterm";
        key = "Meta+Alt+K";
        command = "wezterm";
      };

      fonts = {
        general = {
          family = "Maple Mono";
          pointSize = 12;
        };
      };
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
