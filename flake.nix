{
  description = "Description for the project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/7c9cc5a6e5d38010801741ac830a3f8fd667a7a0"; # nixos-unstable";
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
