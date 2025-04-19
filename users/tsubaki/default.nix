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

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nix-output-monitor
    fastfetch
    nixfmt-rfc-style
    clash-verge-rev
    bitwarden-desktop
    thunderbird
    yubioath-flutter
    zenith
    yazi
    cider
    vlc
    rustup
    obs-studio
    qq
    cinny-desktop
    osu-lazer-bin
    wezterm
    wechat-uos
    gdlauncher-carbon
    vscode-fhs
    inputs.zen-browser.packages."${system}".specific
    wineWowPackages.stable

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
