{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    stdenv
    gcc
    wget
    git
    neovim
  ];
}
