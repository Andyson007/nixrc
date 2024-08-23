{ pkgs, nixpkgs-unstable, ... }:
{
  environment.systemPackages = (with pkgs; [
    stdenv
    git
    (pkgs.writeShellScriptBin "rebuild" ''
      pushd /home/andy/.nixrc/
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
      fi
      popd
    '')
  ]);
}
