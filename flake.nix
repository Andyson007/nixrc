{

	description = "Flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager/release-24.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs@{
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ... 
 }: 
  {
		nixosConfigurations.andyco = nixpkgs.lib.nixosSystem rec {
			system = "x86_64-linux";
			specialArgs = {
        inherit inputs;
        nixpkgs-unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            users.andy = import ./users/andy/andy.nix;
            extraSpecialArgs = {
              nixpkgs-unstable = import nixpkgs-unstable {
                inherit system;
                config.allowUnfree = true;
              };
            };
          };
        }
			];
		};
	};
}
