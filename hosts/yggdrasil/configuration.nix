{ inputs, cfg, pkg, config, ... }:
{
  inputs = [
    ./fs.nix
    ../../services/cloudflared
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    tmp = {
      useTmpfs = true;
      tmpfsSize = "80%";
    };
  };

  # Network Settings
  networking = {
    hostName = "yggdrasil";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;

    firewall = {
      enable = true;
      allowPing = false;
    };
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    wget
    git
    gcc
  ];

  # Users
  users.users = {
    tsubaki = {
      isNormalUser = true;
      description = "Noob coder, need cat";
      uid = 1000;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };

    beef = {
      isNormalUser = true;
      description = "Legend coder";
      uid = 1000;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };

  # Nix Settings
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
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
  };

  # The Rest
  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";
}