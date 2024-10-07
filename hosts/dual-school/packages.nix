{
  pkgs,
  nixpkgs-unstable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    virtualbox
    stdenv
    gcc
    wget
    git
    wl-clipboard
    lxqt.lxqt-policykit
    xdg-desktop-portal-wlr
    xdg-utils
    qt6ct
    nerdfonts
  ];
}
