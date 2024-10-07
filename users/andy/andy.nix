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
    services.atuin.enable = true;
    programs.zsh.enable = true;
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = ["andy"];

    environment.sessionVariables = {
      XDG_CONFIG_HOME = "$HOME/.config";
      NIXOS_OZONE_WL = 1;
      EDITOR = "nvim";
      DOTNET_CLI_TELEMETRY_OPTOUT = 1;
    };

    users.users."andy" = {
      isNormalUser = true;
      home = "/home/andy";
      extraGroups = ["wheel" "networkmanager"];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = config.andy.sshKeys;
      packages =
        (with pkgs; [
          openssl
          usbutils
          pkg-config
          fd
          ntfy-sh
          atuin
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
          gnumake
          alejandra # Foratter for nix
          # os stuff
          cargo-binutils
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
          # browser
          firefox
          ungoogled-chromium
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
          speedtest-rs
          trippy

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
          asm-lsp
          # fun stuff
          cowsay
          fortune
          toilet
          # games
          prismlauncher
          openjdk17
        ])
        ++ (with nixpkgs-unstable; [
          neovim
          neovide
          stockfish
          discord
          rust-analyzer
        ]);
    };
  };
}
