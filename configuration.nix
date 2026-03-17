{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Boot
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };

  # Networking
  networking = {
    hostName = "thinkpad-E14";
    networkmanager.enable = true;
  };

  # i18n
  time.timeZone = "Asia/Kolkata";
  i18n = {
    defaultLocale = "en_IN";
    extraLocaleSettings = {
      LC_ADDRESS = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_MONETARY = "en_IN";
      LC_NAME = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_PAPER = "en_IN";
      LC_TELEPHONE = "en_IN";
      LC_TIME = "en_IN";
    };
  };

  # X11 & GNOME
  services.xserver = {
    enable = true;
    xkb = { layout = "us"; variant = ""; };
  };

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour gnome-characters gnome-maps gnome-weather epiphany
    cheese simple-scan brasero gnome-logs gnome-contacts
    gnome-connections gnome-music gnome-user-docs yelp
  ];

  # Power Management
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;
      WIFI_PWR_ON_BAT = 0;
      BLUETOOTH_PWR_ON_BAT = 0;
    };
  };
  services.power-profiles-daemon.enable = false;
  services.thermald.enable = true;

  # Microphone LED fix (ThinkPad)
  systemd.services.disable-mic-led = {
    description = "Disable microphone LED";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo 0 > /sys/class/leds/platform::micmute/brightness || true'";
    };
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-logind.service" ];
  };

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="leds", KERNEL=="platform::micmute", RUN+="${pkgs.bash}/bin/bash -c 'echo 0 > /sys/class/leds/platform::micmute/brightness || true'"
  '';

  # Audio
  services = {
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa = { enable = true; support32Bit = true; };
      pulse.enable = true;
    };
  };
  security.rtkit.enable = true;

  # User
  users.users.aryan = {
    isNormalUser = true;
    description = "Aryan";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  # Programs
  programs.nix-ld.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    enableSSHSupport = true;
  };

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/home/aryan/.config/sops/age/keys.txt";
  };

  # Docker
  virtualisation.docker = {
    enable = true;
    rootless = { enable = true; setSocketVariable = true; };
    storageDriver = "overlay2";
    autoPrune.enable = true;
    autoPrune.dates = "weekly";
  };

  # Nix
  nixpkgs.config = {
    allowUnfree = true;
    vivaldi = { proprietaryCodecs = true; enableWideVine = true; };
  };
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [ "https://nix-community.cachix.org" ];
    trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
    max-jobs = "auto";
    keep-outputs = false;
    keep-derivations = false;
  };
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 3";
    flake = "/home/aryan/nixos-config";
  };
  nix.optimise = {
    automatic = true;
    dates = [ "18:00" ];
  };

  # Hardware
  services.fstrim.enable = true;
  hardware = {
    cpu.amd.updateMicrocode = true;
    graphics = { enable = true; enable32Bit = true; };
    bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings.General.AutoEnable = false;
    };
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    wget aria2 git ffmpeg nil
    libgda5 gsound gnomeExtensions.pano
  ];

  system.stateVersion = "25.11";
}
