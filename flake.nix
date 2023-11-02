{
  description = "Description for the project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = inputs@{ flake-parts, nixpkgs,  sops-nix , ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      perSystem = { config, pkgs, self', inputs', ... }: {
        # Per-system attributes can be defined here. The self' and inputs'
        # module parameters provide easy access to attributes of the same
        # system.

        # packages.figlet = inputs'.nixpkgs.legacyPackages.figlet;

        packages.nr = pkgs.callPackage ./packages/utils/nr/default.nix { };
      };
      flake = {
        nixosConfigurations.reese = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./boot.nix
            ./cuda.nix
            ./lizelive.nix
            ./common.nix
            ./programs.nix
            ./wayland.nix
            ./gnome.nix
            ./graphical-tools.nix
            ./reese/configuration.nix
            ./builde.nix
            # sops-nix.nixosModules.sops
          ];
        };
        nixosConfigurations.blathers = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./boot.nix
            ./cuda.nix
            ./lizelive.nix
            ./common.nix
            ./programs.nix
            ./blathers/configuration.nix
            ./builder.nix
          ];
        };
      };
    };
}
