{ pkgs, nixpkgs-unstable, ... }:
{
  environment.systemPackages = (with pkgs; [
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
}