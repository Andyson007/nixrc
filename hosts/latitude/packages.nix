{
  pkgs,
  nixpkgs-unstable,
  ...
}: {
  environment.systemPackages =
    (with pkgs; [
      stdenv
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
    ])
    ++ [
      nixpkgs-unstable.hyprlock
    ];
}
