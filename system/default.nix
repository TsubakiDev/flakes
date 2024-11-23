{ config, pkgs, ... }:

{
  imports = [
    ../common
    ../services
  ];

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tsubaki = {
    isNormalUser = true;
    description = "tsubaki";
    uid = 1000;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };

  programs = {
    fish.enable = true;

    dconf.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  zramSwap.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    gcc
  ];

  system.stateVersion = "24.11"; # Did you read the comment?
}
