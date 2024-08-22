{ pkgs, nixpkgs-unstable, ... }:
{
  home.packages = (with pkgs; [
    kanshi
    fd
    alacritty
    firefox
    cliphist
    tofi
    lazygit
    delta
    zsh
    rustup
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
      monitor=$(${pkgs.hyprland}/bin/hyprctl monitors  | grep Monitor | awk '{print $2}' | ${pkgs.tofi}/bin/tofi)
      ${pkgs.hyprland}/bin/hyprctl dispatch movecurrentworkspacetomonitor $monitor
    '')
    nwg-displays
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
    discord
  ]);
}
