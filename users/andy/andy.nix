{
  pkgs,
  lib,
  config,
  nixpkgs-unstable,
  ...
}: {
  options.andy = let
    inherit (lib) mkOption types;
  in {
    sshKeys = mkOption {
      type = types.listOf types.str;
      default = [];
      example = "andy.sshKeys = [
        ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF9n+QZCLeyMKBqNFIEgZ2hfaH81s+xrIDvgzBiuGwVw
      ]";
    };
  };

  config = {
    services = {
      atuin.enable = true;
      upower.enable = true;
      gvfs.enable = true;
      spotifyd.enable = true;
    };
    programs = {
      zsh.enable = true;
      direnv.enable = true;
    };

    environment.sessionVariables = {
      XDG_CONFIG_HOME = "$HOME/.config";
      NIXOS_OZONE_WL = 1;
      EDITOR = "nvim";
      DOTNET_CLI_TELEMETRY_OPTOUT = 1;
    };

    users.users."andy" = {
      isNormalUser = true;
      home = "/home/andy";
      extraGroups = ["wheel" "networkmanager" "dialout"];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = config.andy.sshKeys;
      packages =
        (with pkgs; [
          libreoffice
          openssl
          usbutils
          pkg-config
          ntfy-sh
          atuin
          geogebra6
          gimp
          # pickers
          fzf
          tofi
          unipicker
          cliphist
          # git stuff
          lazygit
          delta
          stow
          git
          # programming language stuff
          gdb
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
          spotify
          pulsemixer
          # styling
          fastfetch
          bat
          starship
          lsd
          # Window manager stuff
          slurp
          grim
          dunst
          kanshi
          alacritty
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
          prismlauncher
          openjdk17
          openjdk8
          #editor stuff
          neovim
          neovide
        ])
        ++ (with nixpkgs-unstable; [
          stockfish
          discord
          rust-analyzer
          nodejs
          rustup
        ]);
    };
  };
}
