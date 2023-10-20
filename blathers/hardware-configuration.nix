# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/22653a72-02b9-4c2d-a605-1e8514ddeb91";
    fsType = "btrfs";
    options = ["subvol=root" "compress=zstd"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/22653a72-02b9-4c2d-a605-1e8514ddeb91";
    fsType = "btrfs";
    options = ["subvol=nix" "compress=zstd" "noatime"];
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/22653a72-02b9-4c2d-a605-1e8514ddeb91";
    fsType = "btrfs";
    options = ["subvol=log" "compress=zstd"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/22653a72-02b9-4c2d-a605-1e8514ddeb91";
    fsType = "btrfs";
    options = ["subvol=home" "compress=zstd"];
  };

  fileSystems."/var/cache" = {
    device = "/dev/disk/by-uuid/22653a72-02b9-4c2d-a605-1e8514ddeb91";
    fsType = "btrfs";
    options = ["subvol=cache" "compress=zstd"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-path/pci-0000:04:00.3-usb-0:3:1.0-scsi-0:0:0:0-part1";
    fsType = "vfat";
  };

  swapDevices = [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
