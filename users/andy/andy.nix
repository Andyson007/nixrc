{
  config,
  pkgs,
  nixpkgs-unstable,
  ...
}: {
  programs.zsh.enable = true;
  environment.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    NIXOS_OZONE_WL = 1;
    QT_QPA_PLATFORMTHEME = "qt6ct";
    DOTNET_CLI_TELEMTRY_OPTOUT = 1;
    EDITOR = "nvim";
  };

  users.users."andy" = {
    isNormalUser = true;
    home = "/home/andy";
    extraGroups = ["wheel" "networkmanager"];
    shell = pkgs.zsh;
    packages =
      (with pkgs; [
        openssl
        fd
        ntfy-sh
        # VM stuff
        qemu
        nasm
        # pickers
        fzf
        tofi
        unipicker
        cliphist
        # git stuff
        lazygit
        delta
        stow
        gh
        git
        # programming language stuff
        rustup
        bacon
        go
        jq
        python3
        poetry
        elan # Lean stuff
        nodejs
        yarn
        ghc
        dotnetCorePackages.sdk_8_0_2xx
        cmake
        alejandra # Foratter for nix
        # Notes
        obsidian
        # Music
        spotify
        pulsemixer
        # modelling
        blender
        # styling
        fastfetch
        bat
        starship
        ags
        lsd
        # Window manager stuff
        slurp
        grim
        dunst
        kanshi
        alacritty
        firefox
        # rest
        unzip
        entr
        btop
        xxd
        linuxPackages_latest.perf
        nwg-displays
        # Networking
        nmap
        netcat-gnu
        # Nice rust packages
        zoxide
        dust
        ripgrep
        cargo-generate
        rink

        # lsp servers (for nvim)
        rust-analyzer
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
        nodePackages.intelephense
        vale
        asm-lsp
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
  };
}
