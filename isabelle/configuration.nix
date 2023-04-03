# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./cachix.nix
    # <home-manager/nixos>
  ];

  # ipfs
  # still crashes my router as of mar 2023
  services.kubo = {
    # enable = true;
    # autoMount = true;
    localDiscovery = true;
  };

  virtualisation.podman = { enable = false;
  enableNvidia = true; } ;
  # virtualisation.podman.dockerSocket.enable = true;
  virtualisation.containerd = { enable = false; };
  #  nixpkgs.config.packageOverrides = self : rec {
  #    blender = self.blender.override {
  #      cudaSupport = true;
  #    };
  #  };

  programs.singularity.enable = false;
  services.xserver.videoDrivers = ["nvidia"];

  environment.shellAliases = {
    conda-shell = "nix run nixpkgs#conda -- conda-shell";
    nix-fmt = "nix run nixpkgs#alejandra --";
    nixos-config = "sudo gnome-text-editor /etc/nixos/configuration.nix && sudo nixos-rebuild switch";
    glances = "nix-shell -p glances --run 'sudo glances'";
  };

programs.git = { enable = true; lfs.enable = true; };

  programs.bash.interactiveShellInit = ''
    shopt -s histappend
    eval "$(direnv hook bash)"
  '';

  services.postgresql = {
    enable = false;
    settings = {
      shared_buffers = "1GB";
    };
    ensureDatabases = ["minetest"];
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="03e7", MODE="0666"
  '';

  hardware.nvidia = {
  	package = config.boot.kernelPackages.nvidiaPackages.latest;
  	# for headless
  	# nvidiaPersistenced = true;
  	# allow hybernate
  	# powerManagement.enable = true;
  };

  hardware.opengl.driSupport32Bit = true;
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
    daemon.settings = {"features" = {"buildkit" = true;};};
  };
  programs.gamemode.enable = true;
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub.useOSProber = false;
  services.flatpak.enable = false;

  networking.hostName = "l05"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # networking.firewall.enable = false;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.opengl.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enabnle = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  programs.steam = {
    enable = false;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  security.sudo.wheelNeedsPassword = false;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lizelive = {
    isNormalUser = true;
    description = "LizeLive";
    extraGroups = ["networkmanager" "wheel" "docker" "adbusers" "podman"];
    packages = with pkgs; [
      vscode
      obs-studio
      # blender
      gimp
      krita
      prismlauncher
      # discord
      dolphin-emu
      microsoft-edge
      minetest
    ];
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = false;
  services.xserver.displayManager.autoLogin.user = "lizelive";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    # cudaSupport = true;
    # 3080 is 8.6
    # 4090 is 8.9; sm_89 virt target compute_89
    # gpuTargets = [ "8.6" ];
    # cudaCapabilities = [ "8.6" ];
    # use the latest version because i hate myself
    # cudaVersion = "12.0";
  };

  networking.hostId = builtins.substring 0 8 (builtins.readFile "/etc/machine-id");
  boot.supportedFilesystems = [
    # "zfs"
    "btrfs"
  ];
  # boot.zfs.extraPools = [ "ftcg" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    nano
    tree
    bintools
    lsof
    # cri-tools
    # nerdctl
    # kubo
    wget2
    direnv
    helix
    jq
    tailscale
    cachix
    nmap
    iozone gptfdisk
    (import (fetchTarball https://github.com/cachix/devenv/archive/v0.6.2.tar.gz)).default
  ];

  networking.firewall = {
    enable = true;
    # 3000 -> minetest server
    allowedTCPPorts = [30000];
    allowedUDPPorts = [30000];
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
