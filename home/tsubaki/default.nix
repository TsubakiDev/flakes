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
      nswitch = "sudo bash -c 'nixos-rebuild switch |& nom'";
    };
  };

  home.packages = with pkgs; [
    fastfetch
    rustup
    go
  ];

  programs = {
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
