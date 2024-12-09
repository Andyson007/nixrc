{
  pkgs,
  nixpkgs-unstable,
  ...
}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };
  environment.systemPackages =
    (with pkgs; [
      hyprpaper
      hypridle
    ])
    ++ [
      nixpkgs-unstable.swaylock
    ];
}
