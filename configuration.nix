# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, nixpkgs-unstable, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # inputs.home-manager.nixosModules.default
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "andyco";
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Oslo";

  systemd.sleep.extraConfig = ''
  HibernateDelaySec=3600s
  '';

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware = {
    bluetooth.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.andy = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
     shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  environment.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    NIXOS_OZONE_WL = 1;
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = (with pkgs; [
    gcc
    wget
    git
    wl-clipboard
    lxqt.lxqt-policykit
    hyprpaper
    hypridle
    xdg-desktop-portal-wlr
    xdg-utils
    qt6ct
    nerdfonts
    (pkgs.writeShellScriptBin "rebuild" ''
      pushd /home/andy/.config/.nixrc/
      ${pkgs.git}/bin/git diff
      echo "Write a commit message"
      read commit_message
      sudo nixos-rebuild switch --flake .
      if [[ $? -eq 0 ]]; then
        ${pkgs.git}/bin/git add .
        ${pkgs.git}/bin/git commit -m "$commit_message"
        ${pkgs.git}/bin/git push origin main
      fi
      popd
    '')
    (pkgs.writeShellScriptBin "disable_main_monitor" ''
    ${pkgs.hyprland}/bin/hyprctl keyword monitor "eDP-1,disable"
    '')
    (pkgs.writeShellScriptBin "toggle_opacity" ''
    prev_opcatiy=$(${pkgs.hyprland}/bin/hyprctl getoption decoration:fullscreen_opacity | awk 'NR==1{print $2}')
    if [[ "$prev_opcatiy" = 1.000000 ]]; then
      ${pkgs.hyprland}/bin/hyprctl --batch "\
        keyword decoration:active_opacity .9;\
        keyword decoration:inactive_opacity .9;\
        keyword decoration:fullscreen_opacity .9"
    else
      ${pkgs.hyprland}/bin/hyprctl --batch "\
        keyword decoration:active_opacity 1;\
        keyword decoration:inactive_opacity 1;\
        keyword decoration:fullscreen_opacity 1"
    fi

    '')
  ]) ++ [
    nixpkgs-unstable.hyprlock
  ];


	# home-manager = {
	# 	extraSpecialArgs = {inherit inputs; inherit nixpkgs-unstable; };
	# 	users = {
	# 		"andy" = import ./users/andy.nix;
	# 	};
	# };

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
  #   enable = false;
  # };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [3000];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  programs.hyprland.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [

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
    (nerdfonts.override { fonts = [ "0xProto" ]; })
  ];
}
