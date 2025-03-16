{ cfg, pkg, config, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };

    tmp = {
      useTmpfs = true;
      tmpfsSize = "80%";
    };
  };

  # Networking Settings
  networking = {
    hostName = "cloudvalley";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    mcdreforged
    git
    zenith
    tmux
  ];

  # Users
  users.users = {
    tsubaki = {
      isNormalUser = true;
      description = "Server staff.";
      uid = 1000;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };

    server = {
      isNormalUser = false;
      description = "The account that starts the server.";
      uid = 1001;
      extraGroups = [];
    };
  };

  # Java Settings
  programs.java = {
    enable = true;
    package = pkgs.graalvm-ce;
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
      dates = "daily";
      options = "--delete-older-than 1d";
    };
  };

  # The Rest
  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";
  system.stateVersion = "24.11";
}