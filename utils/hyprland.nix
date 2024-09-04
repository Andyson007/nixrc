{
  pkgs,
  nixpkgs-unstable,
  ...
}: {
  programs.hyprland.enable = true;
  environment.systemPackages =
    (with pkgs; [
      hyprpaper
      hypridle
    ])
    ++ [
      nixpkgs-unstable.hyprlock
    ];
}
