{
  pkgs,
  lib,
  config,
  nixpkgs-unstable,
  ...
}: {
  options.andy = let
    inherit (lib) mkOption types;
  in {
    windowmanager = {
      enable = mkOption {
        type = types.bool;
        default = true;
      };
    };
    hostName = mkOption {
      type = types.str;
      example = "andyco";
      default = "andyco";
    };
    sshKeys = mkOption {
      type = types.listOf types.str;
      default = [];
      example = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF9n+QZCLeyMKBqNFIEgZ2hfaH81s+xrIDvgzBiuGwVw"];
    };
    timeZone = mkOption {
      type = types.str;
      default = "Europe/Oslo";
      example = "Europe/Oslo";
    };
    allowUnfree = mkOption {
      type = types.bool;
      default = true;
    };
  };

  imports = [./wm.nix];

  config = {
    hardware.bluetooth.enable = true;
    console.useXkbConfig = true;

    services = {
      atuin.enable = true;
      upower.enable = true;
      gvfs.enable = true;
      xserver.xkb = {
        layout = "us";
        variant = "dvp";
      };
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };

    programs = {
      zsh.enable = true;
      direnv.enable = true;
    };

    networking = {
      hostName = config.andy.hostName;
      networkmanager.enable = true;
    };

    nixpkgs.config.allowUnfree = config.andy.allowUnfree;

    time.timeZone = config.andy.timeZone;

    environment.sessionVariables = {
      XDG_CONFIG_HOME = "$HOME/.config";
      NIXOS_OZONE_WL = 1;
      EDITOR = "nvim";
      DOTNET_CLI_TELEMETRY_OPTOUT = 1;
    };

    users.users."andy" = {
      isNormalUser = true;
      home = "/home/andy";
      extraGroups = ["wheel" "networkmanager" "dialout" "disk"];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = config.andy.sshKeys;
      packages = import ./packages.nix {
        inherit pkgs nixpkgs-unstable;
        enable_de_stuff = config.andy.windowmanager.enable;
      };
    };

    fonts.packages = with pkgs; [
      (nerdfonts.override {fonts = ["0xProto"];})
    ];

    services.cron = {
      enable = true;
      systemCronJobs = [
        "* * * * * andy ${../../scripts/red_outline_low_battery.sh}"
      ];
    };
  };
}
