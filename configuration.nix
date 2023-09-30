# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  ...
}: {
  # Set your time zone.
  time.timeZone = "America/Los_Angeles";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # setup sudo
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  # set the hostId to the first 8 characters of the machine-id
  # networking.hostId = builtins.substring 0 8 (builtins.readFile "/etc/machine-id");

  # use podman
  virtualisation = {
    docker = {
      enable = true;
      enableNvidia = true;
      extraOptions = "--cri-containerd";
      # settings = {
      #   features = {
      #     containerd-snapshotter = true;
      #   };
      # };
    };
    podman = { enable = true; enableNvidia = true; };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  programs.gamemode.enable = true;

  services.squid = {
    enable = false;
    extraConfig = ''
    acl co_huggingface dstdomain huggingface.co
    cache allow co_huggingface
    
    acl org_pythonhosted_files dstdomain files.pythonhosted.org
    cache allow org_pythonhosted_files

    acl org_debian_deb dstdomain org_debian_deb
    cache allow org_debian_deb

    acl com_microsoft_packages dstdomain packages.microsoft.com
    cache allow com_microsoft_packages
    
    maximum_object_size 16 GB
    cache_dir ufs /var/cache/squid 500000 256 256
    cache_mem 256 MB
    maximum_object_size_in_memory 4 KB
    cache_replacement_policy heap LFUDA
    range_offset_limit -1
    quick_abort_min -1 KB
    '';
  };

networking.firewall = {
  enable = true;
  allowedTCPPorts = [ 6567 ];
  allowedUDPPorts = [ 6567 ];
};

  # networking.proxy.default = "http://127.0.0.1:3128"; # "http://localhost:3128";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  # auto upgrade
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
  };

  # cleanup
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
