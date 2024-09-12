{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "rebuild" ''
      pushd /home/andy/.nixrc/
      ${pkgs.alejandra}/bin/alejandra . --quiet
      ${pkgs.git}/bin/git diff
      ${pkgs.git}/bin/git add .
      echo "Write a commit message"
      read commit_message
      sudo nixos-rebuild switch --flake .
      if [[ $? -eq 0 ]]; then
        ${pkgs.git}/bin/git commit -m "$commit_message"
        ${pkgs.git}/bin/git push origin main
      else
        git reset
        ${pkgs.alejandra}/bin/alejandra . --quiet
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
    (pkgs.writeShellScriptBin "swap_monitor" ''
      monitor=$(${pkgs.hyprland}/bin/hyprctl monitors  | grep Monitor | awk '{print $2}' | ${pkgs.tofi}/bin/tofi)
      ${pkgs.hyprland}/bin/hyprctl dispatch movecurrentworkspacetomonitor $monitor
    '')
    (pkgs.writeShellScriptBin "start" ''
      Hyprland
      exit
    '')
  ];
}
