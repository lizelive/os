{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # set the kernel for zfs
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

  hardware.opengl = { enable = true; driSupport32Bit = true; };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = { nvidiaPersistenced = true; package = config.boot.kernelPackages.nvidiaPackages.beta; };
  
# Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  networking.hostName = "blathers"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = false;


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = false;
  services.xserver.desktopManager.gnome.enable = false;
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lizelive = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       vscode       
     ];
     openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOU1vPhNxJbXF2Gaq40kbKQ7bt7darBTNCTqDPq180yo" ];
  };

  security.sudo.wheelNeedsPassword = false;
  # services.mingetty.autologinUser = "lizelive";
  
  # configure nixpkgs
  nixpkgs.config = {
    allowUnfree = true;
    # cudaSupport = true;
    # 3080 is 8.6
    # 4090 is 8.9; sm_89 virt target compute_89
    # # gpuTargets = [ "8.9" ]; # used for non-nvidia gpus
    # cudaCapabilities = [ "8.9" ];
    # use the latest version because i hate myself
    # cudaVersion = "12.0";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  virtualisation.docker = { enable = true; enableNvidia = true; storageDriver = "zfs"; };

  # List services that you want to enable:

  # podman
  # virtualisation.podman = { enable = true; enableNvidia = true; } ;

  # zfs scrub
  services.zfs.autoScrub.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = { enable = true; passwordAuthentication = false; };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
  system.autoUpgrade = { enable = true; allowReboot = true; }; 
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

