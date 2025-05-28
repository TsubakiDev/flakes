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
        screen
        wget
      ];
    };
  };

  programs.git.enable = true;

  networking = {
    networkmanager.enable = true;
    hostName = "mgtown";
    useDHCP = lib.mkDefault true;
    firewall.enable = false;
  };

  time.timeZone = "Asia/Shanghai";

  powerManagement.cpuFreqGovernor = "performance";

  i18n.defaultLocale = "en_US.UTF-8";

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

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 1d";
  };

  system.stateVersion = "25.05";
}
