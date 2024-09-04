{
  modulesPath,
  pkgs,
  inputs,
  builtins,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./packages.nix
    ../../scripts.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "sandyco";
    networkmanager.enable = true;
    wireless.enable = false;
  };

  time.timeZone = "Europe/Oslo";

  users.users.andy = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK/XR5omfGd2hIt5w70G/7WGsk0/DCPGv0djy8mCppOj andy@andyco"
    ];
  };

  environment.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  services.openssh.enable = true;
  services = {
    postgresql = {
      enable = true;
      package = pkgs.postgresql_16;
      authentication = pkgs.lib.mkOverride 10 ''
        #type database  DBuser  auth-method
        local all       all     trust
        host telefonkatalog       all     127.0.0.1/32 scram-sha-256
      '';
    };
    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
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
}
