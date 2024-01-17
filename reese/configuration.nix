# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config
, pkgs
, lib
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

  nixpkgs.config.allowUnfree = lib.mkForce true;

  # services.xserver.videoDrivers = [  "displaylink" "nvidia" ];

  services.xserver.videoDrivers = [ "nvidia" "displaylink" "modesetting" ];
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  hardware.nvidia = {
    # nvidiaPersistenced = true;
    open = true;
    # powerManagement.enable = true;
    modesetting.enable = true;
    nvidiaSettings = false;
  };



  # disable nvidia
  # boot.extraModprobeConfig = ''
  #   blacklist nouveau
  #   options nouveau modeset=0
  # '';
  # services.udev.extraRules = ''
  #   # Remove NVIDIA USB xHCI Host Controller devices, if present
  #   ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
  #   # Remove NVIDIA USB Type-C UCSI devices, if present
  #   ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
  #   # Remove NVIDIA Audio devices, if present
  #   ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
  #   # Remove NVIDIA VGA/3D controller devices
  #   ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
  # '';
  # boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];


  # hardware.nvidia = {
  #   nvidiaPersistenced = lib.mkForce false;
  #   open = lib.mkForce true;
  #   powerManagement.enable = lib.mkForce false;
  #   modesetting.enable = lib.mkForce false;
  #   nvidiaSettings = lib.mkForce false;
  # };

}
