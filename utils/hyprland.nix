{
  pkgs,
  nixpkgs-unstable,
  ...
}: {
  programs.hyprland = {
    package = nixpkgs-unstable.hyprland;
    enable = true;
  };
  environment.systemPackages =
    (with pkgs; [
      hyprpaper
      hypridle
    ])
    ++ [
      nixpkgs-unstable.hyprlock
    ];
}
