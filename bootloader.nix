{...} : {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
    boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
}