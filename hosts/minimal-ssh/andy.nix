{
  config,
  pkgs,
  nixpkgs-unstable,
  ...
}: {
  imports = [
  ];

  home = {
    username = "andy";
    homeDirectory = "/home/andy";

    stateVersion = "24.05"; # DO NOT CHANGE

    shellAliases = {
      a = "ls --color -klAhs";
      l = "ls --color -klhs";
    };
  };

  programs = {
    git = {
      enable = true;
      userName = "Andyson007";
      userEmail = "andreas.jan.van.der.meulen@gmail.com";
      extraConfig = {
        merge.conflictStyle = "diff3";
        diff.colorMoved = "default";
        alias = {
          staash = "stash --all";
        };
      };
    };

    home-manager.enable = true;
  };
}
