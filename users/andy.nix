{ config, pkgs, nixpkgs-unstable,  ... }:

{
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

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = (with pkgs; [
    fd
    alacritty
    firefox
    cliphist
    tofi
    lazygit
    delta
    zsh
    rustup
    discord
    obsidian
    spotify
    nodejs
    yarn
    unzip
    go
    python3
    poetry
    pulsemixer
    jq
    blender
    fastfetch
    xdotool
    wtype
    entr
    ags
    slurp
    grim
    vale
    btop
    xxd
    linuxPackages_latest.perf
    ghc
    candy-icons
    (pkgs.writeShellScriptBin "swap_monitor" ''
      ${pkgs.wdisplays} &
      wdisplays_pid=$!
      monitor=$(${pkgs.hyprland}/bin/hyprctl monitors  | grep Monitor | awk '{print $2}' | ${pkgs.tofi}/bin/tofi)
      kill $wdisplays_pid
      ${pkgs.hyprland}/bin/hyprctl dispatch movecurrentworkspacetomonitor $monitor
    '')
  # Networking
    nmap
    netcat-gnu
  # Tauri
    dbus
    openssl
    pkg-config
    glib
    gtk3
    libsoup
    webkitgtk
    librsvg
    file
    cmake
    gnumake
    feh
  # Lean
    elan

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
    rink

  # lsp servers
    typescript
    nodePackages_latest.typescript-language-server
    biome
    vscode-langservers-extracted
    emmet-language-server
    tailwindcss
    tailwindcss-language-server
    clang-tools
    lua-language-server
    taplo

    # sql-language-server
    nodePackages_latest.bash-language-server
    haskell-language-server
    nnn
    cowsay
    fortune
    toilet
  ]) ++ (with nixpkgs-unstable; [
    neovim
    neovide
    stockfish
    ollama
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
