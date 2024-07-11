{ config, pkgs, nixpkgs-unstable,  ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "andy";
  home.homeDirectory = "/home/andy";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = (with pkgs; [
    alacritty
    firefox
    cliphist
    tofi
    lazygit
    delta
    zsh
    rustup
    tmux
    discord
    obsidian
    spotify
    nodejs
    yarn
    unzip
    go
    python3
    pulsemixer
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    jq
    blender
    fastfetch
    xdotool
    wtype
    entr
    ags
    dolphin
    slurp
    grim
    vale
    btop
    xxd
    linuxPackages_latest.perf
    ghc
  # Tauri
    pkg-config
    dbus
    openssl
    openssl.dev
    glib
    gtk3
    libsoup
    webkitgtk
    librsvg
    file
    cmake

  # Lichess
    flutter
    coursier
    jdk22
    corepack_22
    # mongodb
    # redis

  # Nice rust packages
    zoxide
    bacon
    lsd
    bat
    dust
    starship
    ripgrep
    cargo-generate

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
  # lsp servers
    typescript
    nodePackages_latest.typescript-language-server
    biome
    vscode-langservers-extracted
    emmet-language-server
    tailwindcss
    clang-tools
    lua-language-server
    taplo

    # sql-language-server
    nodePackages_latest.bash-language-server
    haskell-language-server

  ]) ++ (with nixpkgs-unstable; [
    neovim
    stockfish
  ]);

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

    tmux = {
        enable = true;
        shortcut = "h";
        terminal = "screen-256color";
        extraConfig = ''
            bind h select-pane -L
            bind j select-pane -D
            bind k select-pane -U
            bind l select-pane -R
        '';
    };

    home-manager.enable = true;
  };
}
