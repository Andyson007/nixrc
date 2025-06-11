{pkgs, ...}: {
  imports = [
    ../../utils/wms/hyprland.nix
  ];
  config = {
    environment.systemPackages = with pkgs; [
      wl-clipboard
      lxqt.lxqt-policykit
      xdg-desktop-portal-wlr
      xdg-utils
      qt6ct
    ];
    services.displayManager.sddm.wayland.enable = true;
  };
}
