{ config, lib, pkgs, ... }:
with lib; let
  # Shorter name to access final settings a
  # user of hello.nix module HAS ACTUALLY SET.
  # cfg is a typical convention.
  cfg = options.lizelive.allow;
in {
  # Declare what settings a user of this "hello.nix" module CAN SET.
  options.lizelive.allow  = {
    unfree = mkEnableOption "allow unfree";
  };

  # Define what other settings, services and resources should be active IF
  # a user of this "hello.nix" module ENABLED this module
  # by setting "services.hello.enable = true;".
  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;
  };
}
