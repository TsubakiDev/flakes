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

    # Related
    zola
  ];

  programs.git = {
    enable = true;
    userName = "TsubakiDev";
    userEmail = "i@tsubaki.dev";
    signing = {
      key = "C50CA983F44B4FA3";
    };
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-nix ];
  };

  programs.fish.enable = true;
  programs.home-manager.enable = true;
}
