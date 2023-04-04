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

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

  # services.code-server.enable = true;

  # i don't need nginx
  # services.nginx.enable = true;

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
