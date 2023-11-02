{ config
, pkgs
, ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "blathers"; # Define your hostname.

  virtualisation.docker.storageDriver = "btrfs";

  networking.firewall.allowedTCPPorts = [ 5432 ];
  networking.firewall.enable = false;

  services.prometheus.enable = true;

  # services.grafana = {
  #   enable = true;
  #   settings = {
  #     server = {
  #       # Listening Address
  #       http_addr = "127.0.0.1";
  #       # and Port
  #       http_port = 3000;
  #       # Grafana needs to know on which domain and URL it's running
  #       domain = "blathers.local";
  #       root_url = "https://blathers.local/grafana/"; # Not needed if it is `https://your.domain/`
  #     };
  #   };
  # };

  # services.postgresql = {
  #   enable = true;
  #   package = pkgs.postgresql_15;
  #   enableTCPIP = true;
  #   ensureDatabases = [ "workorder-test" ];
  #   authentication = pkgs.lib.mkOverride 10 ''
  #     local all all trust
  #     host all all 127.0.0.1/32 trust
  #     host all all 192.168.0.2/32 trust
  #     host all all ::1/128 trust
  #   '';
  #   # initialScript = pkgs.writeText "backend-initScript" ''
  #   #   CREATE ROLE nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
  #   #   CREATE DATABASE nixcloud;
  #   #   GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;
  #   # '';
  # };
}
