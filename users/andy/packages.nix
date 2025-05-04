{
  pkgs,
  nixpkgs-unstable,
  enable_de_stuff,
  ...
}:
with pkgs;
  [
    openssl
    usbutils
    pkg-config
    ntfy-sh
    atuin
    # pickers
    fzf
    # git stuff
    lazygit
    delta
    stow
    git
    # programming language stuff
    gdb
    gcc
    ghc
    bacon
    jq
    python3
    yarn
    cmake
    gnumake
    alejandra # Foratter for nix
    # Notes
    obsidian
    # Music
    pulsemixer
    # styling
    fastfetch
    bat
    starship
    lsd
    # browser
    firefox
    ungoogled-chromium
    # rest
    unzip
    btop
    xxd
    # Networking
    nmap
    # Nice rust packages
    zoxide
    dust
    ripgrep
    cargo-generate
    rink
    trippy

    # lsp servers (for nvim)
    typescript
    nodePackages_latest.typescript-language-server
    biome
    vscode-langservers-extracted
    emmet-language-server
    emmet-ls
    tailwindcss
    tailwindcss-language-server
    clang-tools
    lua-language-server
    taplo
    nixd
    nodePackages_latest.bash-language-server
    haskell-language-server
    csharp-ls
    nodePackages.intelephense
    vale
    asm-lsp
    # fun stuff
    cowsay
    fortune
    toilet
    # games
    openjdk17
    openjdk8
    #editor stuff
    neovim
    wget
  ]
  ++ (
    if enable_de_stuff
    then [
      prismlauncher
      slurp
      grim
      dunst
      kanshi
      alacritty
      spotify
      tofi
      geogebra6
      libreoffice
      cliphist
      gimp
      unipicker
      neovide
      brightnessctl
      newsflash
    ]
    else []
  )
  ++ (with nixpkgs-unstable; [
    stockfish
    discord
    rust-analyzer
    nodejs
    spotifyd
    rustup
    ed
  ])
