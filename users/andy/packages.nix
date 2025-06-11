{
  pkgs,
  nixpkgs-unstable,
  enable_de_stuff,
  ...
}:
with pkgs;
  [
    cargo-bootimage
    newsboat
    openssl
    usbutils
    pkg-config
    ntfy-sh
    atuin
    dotnetCorePackages.sdk_9_0_1xx
    spotify
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
    eza
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
    fd
    rusty-man
    zoxide
    dust
    ripgrep
    cargo-generate
    rink
    trippy
    xh

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
    fsautocomplete
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
      kitty
      tofi
      ncspot
      geogebra6
      libreoffice
      cliphist
      unipicker
      neovide
      brightnessctl
      newsflash
      nixpkgs-unstable.gimp3
    ]
    else []
  )
  ++ (with nixpkgs-unstable; [
    stockfish
    discord
    rust-analyzer
    nodejs
    rustup
    ed
    presenterm
  ])
