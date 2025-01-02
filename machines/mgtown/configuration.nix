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

    kernel = {
      sysctl = {
        "kernel.printk" = "4 4 1 7";
        "kernel.panic" = "10";
        "kernel.sysrq" = "0";
        "kernel.core_uses_pid" = "1";
        "kernel.msgmnb" = "65536";
        "kernel.msgmax" = "65536";
        "vm.swappiness" = "0";
        "vm.dirty_ratio" = "80";
        "vm.dirty_background_ratio" = "5";
        "net.core.netdev_max_backlog" = "262144";
        "net.core.rmem_default" = "31457280";
        "net.core.wmem_default" = "31457280";
        "net.core.somaxconn" = "65535";
        "net.core.optmem_max" = "25165824";
        "net.ipv4.neigh.default.gc_thresh1" = "4096";
        "net.ipv4.neigh.default.gc_thresh2" = "8192";
        "net.ipv4.neigh.default.gc_thresh3" = "16384";
        "net.ipv4.neigh.default.gc_interval" = "5";
        "net.ipv4.neigh.default.gc_stale_time" = "120";
        "net.netfilter.nf_conntrack_max" = "10000000";
        "net.netfilter.nf_conntrack_tcp_loose" = "0";
        "net.netfilter.nf_conntrack_tcp_timeout_established" = "1800";
        "net.netfilter.nf_conntrack_tcp_timeout_close" = "10";
        "net.netfilter.nf_conntrack_tcp_timeout_close_wait" = "10";
        "net.netfilter.nf_conntrack_tcp_timeout_fin_wait" = "20";
        "net.netfilter.nf_conntrack_tcp_timeout_last_ack" = "20";
        "net.netfilter.nf_conntrack_tcp_timeout_syn_recv" = "20";
        "net.netfilter.nf_conntrack_tcp_timeout_syn_sent" = "20";
        "net.netfilter.nf_conntrack_tcp_timeout_time_wait" = "10";
        "net.ipv4.tcp_slow_start_after_idle" = "0";
        "net.ipv4.ip_local_port_range" = "1024 65000";
        "net.ipv4.icmp_echo_ignore_all" = "0";
        "net.ipv4.icmp_echo_ignore_broadcasts" = "1";
        "net.ipv4.icmp_ignore_bogus_error_responses" = "1";
        "net.ipv4.tcp_congestion_control" = "bbr";
        "net.core.default_qdisc" = "fq";
        "net.ipv4.tcp_adv_win_scale" = "-2";
        "net.ipv4.tcp_notsent_lowat" = "131072";
        "net.ipv4.tcp_rmem" = "8192 262144 536870912";
        "net.ipv4.tcp_wmem" = "4096 16384 536870912";
        "net.ipv4.udp_rmem_min" = "16384";
        "net.ipv4.udp_wmem_min" = "16384";
        "net.ipv4.tcp_max_tw_buckets" = "1440000";
        "net.ipv4.tcp_tw_recycle" = "0";
        "net.ipv4.tcp_tw_reuse" = "1";
        "net.ipv4.tcp_max_orphans" = "400000";
        "net.ipv4.tcp_window_scaling" = "1";
        "net.ipv4.tcp_rfc1337" = "1";
        "net.ipv4.tcp_syncookies" = "1";
        "net.ipv4.tcp_synack_retries" = "1";
        "net.ipv4.tcp_syn_retries" = "2";
        "net.ipv4.tcp_max_syn_backlog" = "16384";
        "net.ipv4.tcp_timestamps" = "1";
        "net.ipv4.tcp_sack" = "1";
        "net.ipv4.tcp_ecn" = "2";
        "net.ipv4.tcp_fin_timeout" = "10";
        "net.ipv4.tcp_keepalive_time" = "600";
        "net.ipv4.tcp_keepalive_intvl" = "60";
        "net.ipv4.tcp_keepalive_probes" = "10";
        "net.ipv4.tcp_no_metrics_save" = "1";
        "net.ipv4.ip_forward" = "1";
        "net.ipv6.conf.all.forwarding" = "1";
        "net.ipv4.conf.all.accept_redirects" = "0";
        "net.ipv4.conf.all.send_redirects" = "0";
        "net.ipv4.conf.all.accept_source_route" = "0";
        "net.ipv4.conf.all.rp_filter" = "1";
        "net.ipv4.conf.all.mc_forwarding" = "0";
        "net.ipv4.conf.all.log_martians" = "1";
        "kernel.randomize_va_space" = "2";
        "kernel.exec-shield" = "1";
        "net.ipv4.conf.all.proxy_arp" = "0";
        "net.ipv4.conf.all.secure_redirects" = "1";
        "net.ipv4.conf.all.bootp_relay" = "0";
        "net.ipv4.route.flush" = "1";
      };
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
      extraGroups = [ "networkmanager" "wheel" ];
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
    allowedTCPPorts = [ 25565 22255 ];
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
  services.openssh.permitRootLogin = "yes";
  services.openssh.passwordAuthentication = true;

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
    dates = "weekly";
    options = "--delete-older-than 1w";
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