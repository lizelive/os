# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  ...
}: {
  # imports = [
  #   "${toString pkgs.modulesPath}/profiles/all-hardware.nix"
  hardware.enableRedistributableFirmware = true;
  boot.initrd.availableKernelModules = [
    # SATA/PATA support.
    "ahci"

    "ata_piix"

    "sata_inic162x"
    "sata_nv"
    "sata_promise"
    "sata_qstor"
    "sata_sil"
    "sata_sil24"
    "sata_sis"
    "sata_svw"
    "sata_sx4"
    "sata_uli"
    "sata_via"
    "sata_vsc"

    "pata_ali"
    "pata_amd"
    "pata_artop"
    "pata_atiixp"
    "pata_efar"
    "pata_hpt366"
    "pata_hpt37x"
    "pata_hpt3x2n"
    "pata_hpt3x3"
    "pata_it8213"
    "pata_it821x"
    "pata_jmicron"
    "pata_marvell"
    "pata_mpiix"
    "pata_netcell"
    "pata_ns87410"
    "pata_oldpiix"
    "pata_pcmcia"
    "pata_pdc2027x"
    "pata_qdi"
    "pata_rz1000"
    "pata_serverworks"
    "pata_sil680"
    "pata_sis"
    "pata_sl82c105"
    "pata_triflex"
    "pata_via"
    "pata_winbond"

    # SCSI support (incomplete).
    "3w-9xxx"
    "3w-xxxx"
    "aic79xx"
    "aic7xxx"
    "arcmsr"
    "hpsa"

    # USB support, especially for booting from USB CD-ROM
    # drives.
    "uas"

    # SD cards.
    "sdhci_pci"

    # NVMe drives
    "nvme"

    # Firewire support.  Not tested.
    "ohci1394"
    "sbp2"

    # Virtio (QEMU, KVM etc.) support.
    "virtio_net"
    "virtio_pci"
    "virtio_mmio"
    "virtio_blk"
    "virtio_scsi"
    "virtio_balloon"
    "virtio_console"

    # VMware support.
    "mptspi"
    "vmxnet3"
    "vsock"
  ];
  #   "${toString pkgs.modulesPath}/profiles/headless.nix"
  boot.vesa = false;

  # Don't start a tty on the serial consoles.
  systemd.services."serial-getty@ttyS0".enable = lib.mkDefault false;
  systemd.services."serial-getty@hvc0".enable = false;
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@".enable = false;

  # Since we can't manually respond to a panic, just reboot.
  boot.kernelParams = ["panic=1" "boot.panic_on_fail"];

  # Don't allow emergency mode, because we don't have a console.
  systemd.enableEmergencyMode = false;

  # Being headless, we don't need a GRUB splash image.
  boot.loader.grub.splashImage = null;
  # ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "blathers"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.useDHCP = true;
  # networking.useNetworkd = true;
  # systemd.network.enable = true;

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  systemd.services.foo = {
    script = ''
      echo "Doing some stuff" > /a
      lsof -nP -iTCP -sTCP:LISTEN > /b
      echo "Done" > /c
      ifconfig > /d
      echo "Done" > /e
    '';
    wantedBy = ["multi-user.target"];
  };

  virtualisation = {
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      enableNvidia = true;
      # Required for containers under podman-compose to be able to talk to each other.
      # defaultNetwork.dnsname.enable = true;
    };
  };

  services.nginx.enable = true;

  networking.firewall.allowedTCPPorts = [80 22];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lizelive = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "video"];
    openssh.authorizedKeys.keys =
      # builtins.split "\n" (builtins.readFile (builtins.fetchurl https://github.com/lizelive.keys));
      [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDACD+oVWACmBkd8JcRA9ZXWsD6TEsq8ZPiA1WyMnZPoww7flKiW5GCL364sBuppm7cti0ZPnT8MDhYv96w2wqfIYG9c3m8JcfQI12M6ZSUkKVv/GlwlclguSyiqwShqlHdNQyteeXCghZbJS0479ggZs8Mbr4jK9D5KKL1RYRXIAQmMpJHd03m+2cD8WhrZCwT3GIVlna01gLHlPJtg6KVRHcmhKYN/il0iixQnOfwDhoNIkbgSOP5AY0dMioKL+lEnfBR7IlQup/qBtfZKJUTosyvtJWfK2zThHQLV2i51k9+tDxJ2XcYnhewaMF2Pjua3f9ZmfCAkidsoY4UHrIN2eAWtTqIyxnyIKZWA0HTN6kvO5p6IewF+ulsUqcTM+IUH1zmpe82NOMskeaJMz2JdxfZCrnofTzWvca7PzE2BQGALeS7BW+2nRu3IDZtPiZino0NiiJ7AtrRtIoV28WAiLcvMWgtDjkcadAiN1PH5jEW7B73f6vHDKVVZfwlptjUsMY0+/B/jOQiSPbgZcvjlufonL2oUUohuAM/I184MFBlYoyF/V0CRb4mib48rZWsr4biPkXtqtO0woVPZTqPptf1Se56fmdlQeyg3KQUVRTy6Eh60kwelDAfYWbG0FXAERTFwbt+QgEdzJ1iYi8OPOMmXUuUMhSE/p6ORqJWyQ=="
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOU1vPhNxJbXF2Gaq40kbKQ7bt7darBTNCTqDPq180yo"
      ];
    initialHashedPassword = "";
  };

  services.getty.autologinUser = "lizelive";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    # wget
    curl
    tree
    # lsof
    # beep
    busybox
    # vscode
  ];

  programs.git.enable = true;
  programs.git.lfs.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It’s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
