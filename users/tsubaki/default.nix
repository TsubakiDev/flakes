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
    android-studio
    vscode-fhs
    jetbrains.idea-community-bin

    # Internet Messaging
    thunderbird
    telegram-desktop
    discord
    wechat-uos
    qq

    # Media
    cider
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

    # Fonts
    maple-mono.truetype
    maple-mono.NF-unhinted
    maple-mono.NF-CN-unhinted
  ];

  programs = {
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
