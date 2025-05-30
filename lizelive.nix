{ pkgs, ... }:
# let
#   username = "lizelive";
#   file = builtins.fetchurl "https://github.com/${username}.keys";
#   text = builtins.readFile file;
#   lines = builtins.split "\n" text;
#   keys = builtins.filter (v: builtins.isString v && v != "") lines;
# in
{
  users.users.lizelive = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "podman"
      "docker"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOU1vPhNxJbXF2Gaq40kbKQ7bt7darBTNCTqDPq180yo"
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBP9hCD7L1DYXsiqJi9KeUynxHssILCWO4kzHMPoKvXGKnmfCuNEBrQFO/yxdIdQhEe4JHF7aWZgrZ3o339iz8YE="
    ];

    # openssh.authorizedKeys.keys = keys;
  };
}
