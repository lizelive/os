# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config
, pkgs
, ...
}: {
  # programs.singularity.enable = false;
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "reese"; # Define your hostname.

  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.firewall.enable = false;
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

  # services.ddclient = {
  #   enable = true;
  #   ssl = true;
  #   passwordFile = "/root/ddclient.key";
  #   protocol = "googledomains";
  #   domains = [ "reese.lize.live" ];
  #   username = "V4ByJukB6xjFlCgK";
  #   use = "if, usev6=ifv6, ifv6=eno1, usev4=disabled";
  # };

  security.tpm2.enable = true;
  security.tpm2.pkcs11.enable = true;  # expose /run/current-system/sw/lib/libtpm2_pkcs11.so
  security.tpm2.tctiEnvironment.enable = true;  # TPM2TOOLS_TCTI and TPM2_PKCS11_TCTI env variables
  users.users.lizelive.extraGroups = [ "tss" ];  # tss group has access to TPM devices

  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];
}
