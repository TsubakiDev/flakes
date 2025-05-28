{
  pkgs,
  ...
}: 
{
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
      uflake = "sudo nix flake update";
      nswitch = "sudo bash -c 'nixos-rebuild switch |& nom'";
    };
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # Utilities
    nix-output-monitor
    nixfmt-rfc-style
    fastfetch
    zenith
    rustdesk-flutter

    # Development
    rustup
    graalvmPackages.graalvm-ce
    vscode-fhs
    jetbrains.idea-community-bin

    # Internet Messaging
    thunderbird
    telegram-desktop
    wechat-uos
    qq

    # Media
    vlc
    obs-studio
    osu-lazer-bin

    # Password Management
    bitwarden-desktop
    yubioath-flutter

    # Gaming
    steam
    gdlauncher-carbon
    osu-lazer-bin

    # Others
    wezterm
    firefox
    wineWowPackages.stable
    zola

    # Fonts
    iosevka
    noto-fonts-cjk-sans
  ];

  programs.git = {
    enable = true;
    userName = "TsubakiDev";
    userEmail = "i@tsubaki.dev";
    signing = {
      key = "C50CA983F44B4FA3";
      signByDefault = true;
    };
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-nix ];
  };

  programs.fish.enable = true;
  programs.home-manager.enable = true;
}
