{
  pkgs,
  lib,
  config,
  ...
}:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;

    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      grub = {
        enable = true;
        device = "/dev/nvme0n1";
      };
    };
  };

  services.mysql = {
     enable = true;
     package = pkgs.mariadb;
  };

  programs.java.enable = true;
  programs.java.package = pkgs.graalvmPackages.graalvm-ce;

  users.users = {
    mgtown = {
      isNormalUser = true;
      description = "server's default account";
      uid = 1000;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      packages = with pkgs; [
      ];
    };
  };

  networking = {
    networkmanager.enable = true;
    hostName = "mgtown";
    useDHCP = lib.mkDefault true;
  };

  time.timeZone = "Asia/Shanghai";

  powerManagement.cpuFreqGovernor = "performance";

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

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.settings.PasswordAuthentication = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = lib.mkForce [ "https://mirror.iscas.ac.cn/nix-channels/store" ];
    auto-optimise-store = true;
  };

  networking.firewall = {
     enable = true;
     allowPing = false;
     allowedTCPPorts = [ 25565 ];
   };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 1d";
  };

  environment.systemPackages = with pkgs; [
    git
    screen
  ];

  system.stateVersion = "24.11";
}
