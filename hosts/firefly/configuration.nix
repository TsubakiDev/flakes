{
  config,
  pkgs,
  inputs,
  ...
}:
let
  homeFile = import ../../home/tsubaki;
in
{
  imports = [
    ../common
    ../../services
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.users.tsubaki = homeFile;
    }
  ];

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "firefly";

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
  };

  programs = {
    fish.enable = true;
    dconf.enable = true;
    gamemode.enable = true;
    bash.interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    gcc
  ];

  system.stateVersion = "24.11";
}
