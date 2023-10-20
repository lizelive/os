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
  nix.buildMachines = [
    {
      hostName = "nixremote@builder.lize.live";
      system = "x86_64-linux";
      protocol = "ssh-ng";
      maxJobs = 12;
      speedFactor = 2;
      supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
    }
  ];
  nix.distributedBuilds = true;
}
