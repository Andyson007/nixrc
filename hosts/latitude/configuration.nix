{
  config,
  lib,
  pkgs,
  nixpkgs-unstable,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ../../scripts.nix
    ../../utils/hyprland.nix
    ../../users/andy/andy.nix
  ];
  andy.sshKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINC9w9ABoLRmP7PwW95gWvkrx/QiSde0vdrCKW8rOnhV andy@nixos"
  ];
  services.openssh.enable = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "andyco";
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Oslo";

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=3600s
  '';

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # console.useXkbConfig makes it follow the xserver
  services.xserver.xkb = {
    layout = "us";
    variant = "dvp";
  };
  console.useXkbConfig = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware = {
    bluetooth.enable = true;
    opengl.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  environment.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    NIXOS_OZONE_WL = 1;
    QT_QPA_PLATFORMTHEME = "qt6ct";
    DOTNET_CLI_TELEMTRY_OPTOUT = 1;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # networking.firewall.allowedTCPPorts = [3000];
  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

  nix.settings.experimental-features = ["nix-command" "flakes"];
  services.displayManager.sddm.wayland.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      zlib
      libgcc
    ];
  };
  security.polkit.enable = true;

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["0xProto"];})
  ];

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
    ensureDatabases = ["assetmanagement"];
    settings.ssl = true;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
      host assetmanagement       all     127.0.0.1/32 scram-sha-256
      host assetmanagement       all     ::1/128 scram-sha-256
    '';
  };
}
