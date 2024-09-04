{
  pkgs,
  nixpkgs-unstable,
  ...
}: {
  environment.systemPackages = with pkgs;
    [
      curl
      wget
      stdenv
      git
      gcc
    ]
    ++ [
      nixpkgs-unstable.neovim
    ];
}
