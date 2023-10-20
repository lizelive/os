# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  ...
}: let
  pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFHjpgkmBKMrLVLxMkjL47ujU7BKMQqaLg5XlqyPlaco";
in {

  users.users.nixremote = {
    isNormalUser = true;
    # extraGroups = ["wheel" "podman" "docker" ]; # Enable ‘sudo’ for the user.

    openssh.authorizedKeys.keys = [
      pubkey
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIICuaBhbUFqSi7ing96YqExwkOp52pjQoigf9t+jsFnQ root@reese"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOU1vPhNxJbXF2Gaq40kbKQ7bt7darBTNCTqDPq180yo lizelive@reese"
    ];
  };
}
