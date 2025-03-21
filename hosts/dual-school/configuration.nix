{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ../../scripts.nix
    ../../utils/hyprland.nix
    ../../utils/syncthing.nix
    ../../utils/virt-manager.nix
    ../../users/andy/andy.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 3;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "wandyco";
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    extraHosts = ''
      127.0.0.1 attacker.com
      ::1 attacker.com
    '';
    vlans = {
      vlan45 = {
        id = 45;
        interface = "enp3s0f0";
      };
    };
  };

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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh = {
  #   enable = true;
  #   settings.passwordAuthentication = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [3000];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

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
      host verneanbud            all     127.0.0.1/32 scram-sha-256
      host verneanbud            all     ::1/128 scram-sha-256
      host phproject             all     127.0.0.1/32 scram-sha-256
      host phproject             all     ::1/128 scram-sha-256
      host oppdrag2             all     127.0.0.1/32 scram-sha-256
      host oppdrag2             all     ::1/128 scram-sha-256
      host bank             all     127.0.0.1/32 scram-sha-256
      host bank             all     ::1/128 scram-sha-256
      host hvahoot             all     127.0.0.1/32 scram-sha-256
      host hvahoot             all     ::1/128 scram-sha-256
    '';
  };

  virt-manager.username = "andy";
}
