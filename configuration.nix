# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  # Set your time zone.
  time.timeZone = "America/Los_Angeles";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  
    security.sudo = {
      enable = true;
      wheelNeedsPassword =false;
    };

  systemd.services.foo = {
    script = ''
      date > /wtf
      echo "Doing some stuff" >> /wtf
      lsof -nP -iTCP -sTCP:LISTEN >> /wtf
      echo "Done" >> /wtf
      ifconfig > /wtf
      echo "Done" >> /wtf
    '';
    wantedBy = [ "multi-user.target" ];
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

  networking.firewall.allowedTCPPorts = [ 80 22 ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lizelive = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
    openssh.authorizedKeys.keys = # builtins.split "\n" (builtins.readFile (builtins.fetchurl https://github.com/lizelive.keys));
    [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDACD+oVWACmBkd8JcRA9ZXWsD6TEsq8ZPiA1WyMnZPoww7flKiW5GCL364sBuppm7cti0ZPnT8MDhYv96w2wqfIYG9c3m8JcfQI12M6ZSUkKVv/GlwlclguSyiqwShqlHdNQyteeXCghZbJS0479ggZs8Mbr4jK9D5KKL1RYRXIAQmMpJHd03m+2cD8WhrZCwT3GIVlna01gLHlPJtg6KVRHcmhKYN/il0iixQnOfwDhoNIkbgSOP5AY0dMioKL+lEnfBR7IlQup/qBtfZKJUTosyvtJWfK2zThHQLV2i51k9+tDxJ2XcYnhewaMF2Pjua3f9ZmfCAkidsoY4UHrIN2eAWtTqIyxnyIKZWA0HTN6kvO5p6IewF+ulsUqcTM+IUH1zmpe82NOMskeaJMz2JdxfZCrnofTzWvca7PzE2BQGALeS7BW+2nRu3IDZtPiZino0NiiJ7AtrRtIoV28WAiLcvMWgtDjkcadAiN1PH5jEW7B73f6vHDKVVZfwlptjUsMY0+/B/jOQiSPbgZcvjlufonL2oUUohuAM/I184MFBlYoyF/V0CRb4mib48rZWsr4biPkXtqtO0woVPZTqPptf1Se56fmdlQeyg3KQUVRTy6Eh60kwelDAfYWbG0FXAERTFwbt+QgEdzJ1iYi8OPOMmXUuUMhSE/p6ORqJWyQ=="
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOU1vPhNxJbXF2Gaq40kbKQ7bt7darBTNCTqDPq180yo"
    ];
    initialHashedPassword = "";
  };

  system.stateVersion = "23.05"; # Did you read the comment?


  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}

