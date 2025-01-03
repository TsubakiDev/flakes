{ 
  pkgs,
  lib,
  ...
}:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernel.sysctl = {

    };
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

  networking = {
    networkmanager.enable = true;
    hostName = "blogging-server";
    useDHCP = lib.mkDefault true;

    firewall = {
      enable = true;
      allowPing = false;
      allowedTCPPorts = [ 443 ];
    };
  };

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";
  services.openssh.passwordAuthentication = true;

  users.users = {
    tsubaki = {
      isNormalUser = true;
      description = "tsubaki";
      uid = 1000;
      extraGroups = [ "wheel", "networkmanager" ];
    };
  };

  environment.systemPackages = with pkgs; [
    git
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  virtualisation.docker.enable = true;
  services.postgresql.enable = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = lib.mkForce [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 1d";
  };

  system.stateVersion = "24.11";
}