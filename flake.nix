{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv = {
       url = "github:cachix/devenv/latest";
       inputs.nixpkgs.follows = "nixpkgs";
    };
    # sops-nix.url = "github:Mic92/sops-nix";
    # sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    # disko.url = "github:nix-community/disko";
    # disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{
    self,
    nixpkgs,
    home-manager,
    ...
  }: let basemod = ({ pkgs, ... }: {
            boot.isContainer = true;
            system.stateVersion = "23.05";
            system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
        }); in {
    
    nixosConfigurations.modular = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        basemod
        ./modules/tools.nix
      ];
    };
    nixosConfigurations.reese = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./boot.nix
        ./cuda.nix
        ./lizelive.nix
        ./common.nix
        ./programs.nix
        ./xserver.nix
        ./gnome.nix
        ./graphical-tools.nix
        ./games.nix
        ./reese/configuration.nix
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
      ];
    };
    home-manager = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # home-manager.users.jdoe = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };
  }
