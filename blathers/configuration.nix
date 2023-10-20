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

  virtualisation.docker.storageDriver = "btrfs";

  networking.firewall.allowedTCPPorts = [5432];
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
    enableTCPIP = true;
    ensureDatabases = ["workorder-test"];
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all 192.168.0.2/32 trust
      host all all ::1/128 trust
    '';
    # initialScript = pkgs.writeText "backend-initScript" ''
    #   CREATE ROLE nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
    #   CREATE DATABASE nixcloud;
    #   GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;
    # '';
  };
}
