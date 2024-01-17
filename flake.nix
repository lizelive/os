{
  description = "Description for the project";

  inputs = {
    # sops-nix.url = "sops-nix";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    # nixpkgs.follows = "sops-nix/nixpkgs-stable";
  };

  outputs = inputs@{ flake-parts, nixpkgs, ... }:
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
            # ./cuda.nix
            ./lizelive.nix
            ./common.nix
            ./programs.nix
            ./xserver.nix
            ./gnome.nix
            # ./graphical-tools.nix
            ./reese/configuration.nix
            ./builde.nix
            # ./games.nix
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
