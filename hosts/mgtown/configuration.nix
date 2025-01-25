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
  };

  programs.java.enable = true;
  programs.java.package = pkgs.zulu;

  users.users = {
    mgtown = {
      isNormalUser = true;
      description = "Server default account";
      uid = 1000;
      packages = with pkgs; [
      ];
    };

    tsubaki = {
      isNormalUser = true;
      description = "TsubakiDev's account";
      uid = 1001;
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

  networking.firewall = {
    enable = true;
    allowPing = false;
    allowedTCPPorts = [ 25565 ];
    allowedUDPPorts = [ 19132 ];
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
  services.openssh.settings.PermitRootLogin = "yes";
  services.openssh.settings.PasswordAuthentication = true;

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

  environment.systemPackages = with pkgs; [
    git
    fastfetch
    screen
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  system.stateVersion = "24.11";
}
