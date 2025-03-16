{ config, pkgs, ... }:
{
  imports = [
    ./display.nix
    ./sound.nix
    ./dae
  ];

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "chronara";

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

  time.timeZone = "Asia/Shanghai";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

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

  environment.systemPackages = with pkgs; [
    wget
    gcc
  ];

  nix = {
    package = pkgs.lix;

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 1d";
    };
  };

  system.stateVersion = "24.11";
}