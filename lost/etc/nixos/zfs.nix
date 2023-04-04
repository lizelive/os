{
  config,
  pkgs,
  ...
}: {
  boot.supportedFilesystems = ["zfs"];
  networking.hostId = builtins.substring 0 8 (builtins.readFile "/etc/machine-id");
}
