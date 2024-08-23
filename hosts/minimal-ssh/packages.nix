{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    stdenv
    git
    (writeShellScriptBin "rebuild" ''
      pushd /home/andy/.nixrc/
      ${git}/bin/git diff
      ${git}/bin/git add .
      echo "Write a commit message"
      read commit_message
      sudo nixos-rebuild switch --flake .
      if [[ $? -eq 0 ]]; then
        ${git}/bin/git commit -m "$commit_message"
        ${git}/bin/git push origin main
      else
        git reset
      fi
      popd
    '')
  ];
}
