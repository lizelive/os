# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  ...
}: {
  # TODO provide sshKey, publicHostKey
  nix.buildMachines = [
    {
      sshUser = "nixremote";
      hostName = "builder.lize.live";
      system = "x86_64-linux";
      protocol = "ssh-ng";
      maxJobs = 12;
      speedFactor = 2;
      supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
    }
  ];
  nix.distributedBuilds = true;
  programs.ssh.knownHosts.builder = {
    extraHostNames = ["builder.lize.live"];
    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILx0d3LDlX0wPCec41LxqfFhon0VTJmCRbFySpPQuz7C";
  };
}
