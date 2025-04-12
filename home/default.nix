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
    yubikey-manager-qt
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
    obsidian
    inputs.zen-browser.packages."${system}".specific
    wineWowPackages.stable

    maple-mono.truetype
    maple-mono.NF-unhinted
    maple-mono.NF-CN-unhinted
  ];

  programs = {
    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };

    neovim = {
      enable = true;
      
      plugins = with pkgs.vimPlugins; [ 
        vim-nix
        lazy-nvim
      ];
      
      package = pkgs.neovim-nightly;

      extraLuaConfig = ''
          vim.g.mapleader = " " -- Need to set leader before lazy for correct keybindings
          require("lazy").setup({
            performance = {
              reset_packpath = false,
              rtp = {
                 reset = false,
                }
              },
            dev = {
              path = "${pkgs.vimUtils.packDir config.home-manager.users.tsubaki.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
            },
            install = {
              -- Safeguard in case we forget to install a plugin with Nix
              missing = false,
            },
          })
        '';
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
