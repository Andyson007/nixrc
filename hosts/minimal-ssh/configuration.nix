{
  pkgs,
  inputs,
  builtins,
  ...
}: {
  imports = [
    ../../hardware-configuration.nix
    ./packages.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "andyco";
    networkmanager.enable = true;
    wireless.enable = false;
  };

  time.timeZone = "Europe/Oslo";

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=3600s
  '';

  users.users.andy = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      builtins.readFile
      ./keys/id_ed25519.pub
    ];
  };

  environment.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  services.openssh = {
    enable = true;
  };

  networking.firewall.allowedTCPPorts = [22];
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

  nix.settings.experimental-features = ["nix-command" "flakes"];

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
}
