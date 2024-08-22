{ config, pkgs, nixpkgs-unstable,  ... }:
{
  imports = [
    ./packages.nix
    ./kanshi.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "andy";
  home.homeDirectory = "/home/andy";

  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/andy/etc/profile.d/hm-session-vars.sh
  #
  home = {
    sessionVariables = {
      EDITOR = "nvim";
    };
    sessionPath = [
      "$HOME/.cargo/bin"
    ];
  };

  programs = {
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

    zsh = {
      enable = true;
      shellAliases = {
        a = "${pkgs.lsd}/bin/lsd -AFlg";
        l = "${pkgs.lsd}/bin/lsd -Flg";
        lg = "lazygit";
        vim = "${nixpkgs-unstable.neovim}/bin/nvim";
      };
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

    home-manager.enable = true;
  };
}
