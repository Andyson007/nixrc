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
    ]);
}
