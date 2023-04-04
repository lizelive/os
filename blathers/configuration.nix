{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  networking.hostName = "blathers"; # Define your hostname.
}
