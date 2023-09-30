# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  # programs.singularity.enable = false;
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  
  networking.hostName = "reese"; # Define your hostname.

  # # Allow unfree packages
  # nixpkgs.config = {
  #   allowUnfree = true;
  #   # cudaSupport = true;
  #   # 3080 is 8.6
  #   # 4090 is 8.9; sm_89 virt target compute_89
  #   # gpuTargets = [ "8.6" ];
  #   # cudaCapabilities = [ "8.6" ];
  #   # use the latest version because i hate myself
  #   # cudaVersion = "12.0";
  # };

  # boot.kernelPackages = pkgs.linuxPackages_latest;
}
