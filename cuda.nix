{
  pkgs,
  config,
  ...
}: {
  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = true;
    # 3080 is 8.6
    # 4090 is 8.9; sm_89 virt target compute_89
    # # gpuTargets = [ "8.9" ]; # used for non-nvidia gpus
    # cudaCapabilities = [ "8.9" ];
    # use the latest version because i hate myself
    # cudaVersion = "12.0";
  };
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    nvidiaPersistenced = true;
  };

  # unclear why this is needed
  # but without it it does not load the drivers :(
  services.xserver.videoDrivers = ["nvidia"];
}
