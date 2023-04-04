{
  pkgs,
  config,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    nvidiaPersistenced = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
}
