{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # sops-nix.url = "github:Mic92/sops-nix";
    # sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    # disko.url = "github:nix-community/disko";
    # disko.inputs.nixpkgs.follows = "nixpkgs";
    # devenv.url = "github:cachix/devenv/latest";
    # devenv.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self
    , nixpkgs
    , # sops-nix,
      # disko,
      # devenv,
    }: {
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
}
