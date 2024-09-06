{
  config,
  pkgs,
  nixpkgs-unstable,
  ...
}: {
  imports = [
    ./packages.nix
  ];
  home.username = "andy";
  home.homeDirectory = "/home/andy";

  home.stateVersion = "24.05"; # READ HOME MANAGER RELEASE NOTES FIRST
  home.shellAliases = {
    a = "${pkgs.lsd}/bin/lsd -AFlg";
    l = "${pkgs.lsd}/bin/lsd -Flg";
    lg = "${pkgs.lazygit}/bin/lazygit";
    vim = "${nixpkgs-unstable.neovim}/bin/nvim";
  };

  home = {
    sessionVariables = {
      EDITOR = "nvim";
    };
    sessionPath = [
      "$HOME/.cargo/bin"
    ];
  };

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.highlighters = [
        "main"
        "brackets"
      ];
    };

    zoxide.enable = true;
    starship = {
      enable = true;
      settings = {
        format = ''
          $all$hostname$character
        '';
        hostname = {
          ssh_only = false;
          trim_at = " ";
          format = "[$ssh_symbol$hostname]($style)";
          style = "red";
        };
      };
    };

    git = {
      enable = true;
      userName = "Andyson007";
      userEmail = "andreas.jan.van.der.meulen@gmail.com";
      extraConfig = {
        core.pager = "delta";
        interactive.diffFilter = "delta --color-only";
        delta.navigate = true;
        delta.dark = true;
        merge.conflictStyle = "diff3";
        diff.colorMoved = "default";
        alias = {
          staash = "stash --all";
        };
      };
    };

    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
    };

    home-manager.enable = true;
  };
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";
  };
}
