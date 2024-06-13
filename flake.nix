{

	description = "Flake";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-24.05";
		nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager/release-24.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, ... }@inputs: 
  {
		nixosConfigurations.andyco = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = {inherit inputs;};
			modules = [
				./configuration.nix
				inputs.home-manager.nixosModules.default
			];
		};
	};
}
