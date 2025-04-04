{
  pkgs,
  ...
}: 
let
  gdlauncher-carbon-local = pkgs.callPackage ../packages/gdlauncher-carbon.packakge.nix { };
in
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
    qq
    cinny-desktop
    osu-lazer-bin
    wezterm
    google-chrome
    wechat-uos
    gdlauncher-carbon-local
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
