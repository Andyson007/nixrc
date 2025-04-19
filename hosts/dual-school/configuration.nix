{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../scripts.nix
    ../../utils/syncthing.nix
    ../../utils/virt-manager.nix
    ../../utils/postgres.nix
    ../../utils/autoUpgrade.nix
    ../../utils/nix-ld.nix
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

  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

  nix.settings.experimental-features = ["nix-command" "flakes"];

  security.polkit.enable = true;

  virt-manager.username = "andy";
}
