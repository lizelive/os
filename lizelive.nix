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
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINfPYw1BybV5Yl+uWqNEeCUYLAoDXQCo1JxC2rQt6SaG"
    ];

    # openssh.authorizedKeys.keys = keys;
  };
}
