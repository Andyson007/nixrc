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
    shell = pkgs.zsh;
    packages =
      (with pkgs; [
        qemu
        fzf
        openssl
        unipicker
        dunst
        alejandra
        kanshi
        fd
        alacritty
        firefox
        cliphist
        tofi
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
        elan
        nodejs
        yarn
        ghc
        dotnetCorePackages.sdk_8_0_2xx
        make
        cmake
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
