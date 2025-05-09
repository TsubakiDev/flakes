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

  home.packages = with pkgs; [
    zenith
    fastfetch
    nixfmt-rfc-style
  ];

  programs.openssh.enable = true;

  programs.gnupg = {
    enable = true;
    agent.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Tsubaki";
    userEmail = "i@tsubaki.dev"
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-nix ];
  };
}