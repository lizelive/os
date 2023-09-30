{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    sops-nix,
    disko,
  }: {
    # replace 'joes-desktop' with your hostname here.
    nixosConfigurations.reese = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./boot.nix
        ./cuda.nix
        ./lizelive.nix
        ./configuration.nix
        ./programs.nix
        ./xserver.nix
        ./gnome.nix
        ./reese/configuration.nix
        sops-nix.nixosModules.sops
      ];
    };
    nixosConfigurations.blathers = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./boot.nix
        ./cuda.nix
        ./lizelive.nix
        ./configuration.nix
        ./programs.nix
        sops-nix.nixosModules.sops
      ];
    };
  };
}
