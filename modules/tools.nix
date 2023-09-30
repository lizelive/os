{ config, lib, pkgs, ... }:
with lib; let
  # Shorter name to access final settings a
  # user of hello.nix module HAS ACTUALLY SET.
  # cfg is a typical convention.
  cfg = options.lizelive.tools;
in {
  # Declare what settings a user of this "hello.nix" module CAN SET.
  cfg = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = lib.mdDoc ''
        CLI tools I use a lot.
      '';
    };
    # enable = mkEnableOption "dev tools";
  };

  # Define what other settings, services and resources should be active IF
  # a user of this "hello.nix" module ENABLED this module
  # by setting "services.hello.enable = true;".
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nano # simple text editor
      busybox # pciutils, usbutils, wget. not sure if i want all of these features
      curl # curl
      tree # directory tree
      kubo # ipfs
      direnv # direnv (https://direnv.net/)  load and unload environment variables depending on the current directory.
      jq # json stuff
      cachix # nix cache
      nmap # map network
      gptfdisk # format gpt disk
      kubectl # manage cukernetes
      glances # system monitor
      alejandra # nix formater
      vscode # offical vscode
    ];
  };
}
