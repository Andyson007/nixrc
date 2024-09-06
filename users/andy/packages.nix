{
  pkgs,
  nixpkgs-unstable,
  ...
}: {
  home.packages =
    (with pkgs; [
      qemu
      fzf
      openssl
      dotnetCorePackages.sdk_8_0_2xx
      unipicker
      dunst
      alejandra
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
      stow
      home-manager
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
      nwg-displays
      # Networking
      nmap
      netcat-gnu
      # Lean
      elan

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
      nixd
      nodePackages_latest.bash-language-server
      haskell-language-server
      csharp-ls
      nnn
      nodePackages.intelephense
      # fun stuff
      cowsay
      fortune
      toilet
    ])
    ++ (with nixpkgs-unstable; [
      neovim
      neovide
      stockfish
      discord
    ]);
}
