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

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=3600s
  '';
  andy.hostName = "wandyco";
  networking = {
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

  # Enable the OpenSSH daemon.
  # services.openssh = {
  #   enable = true;
  #   settings.passwordAuthentication = true;
  # };

  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
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

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
    settings.ssl = true;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database           DBuser  auth-method
      local all                all     trust
      host  assetmanagement    all     127.0.0.1/32 scram-sha-256
      host  assetmanagement    all     ::1/128 scram-sha-256
      host  verneanbud         all     127.0.0.1/32 scram-sha-256
      host  verneanbud         all     ::1/128 scram-sha-256
      host  phproject          all     127.0.0.1/32 scram-sha-256
      host  phproject          all     ::1/128 scram-sha-256
      host  oppdrag2           all     127.0.0.1/32 scram-sha-256
      host  oppdrag2           all     ::1/128 scram-sha-256
      host  bank               all     127.0.0.1/32 scram-sha-256
      host  bank               all     ::1/128 scram-sha-256
      host  hvahoot            all     127.0.0.1/32 scram-sha-256
      host  hvahoot            all     ::1/128 scram-sha-256
    '';
  };

  virt-manager.username = "andy";
}
