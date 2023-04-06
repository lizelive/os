{pkgs, ...}: {
  # use podman
  virtualisation = {
    podman = {
      enable = true;

      # replace docker with podman
      # dockerCompat = true;
      # dockerSocket.enable = true;

      # cuda is needed
      enableNvidia = true;

      # Required for containers under podman-compose to be able to talk to each other.
      # defaultNetwork.dnsname.enable = true;
    };

    containers.storage.settings.storage = {
      driver = "btrfs";
      graphroot = "/var/lib/containers/storage";
      runroot = "/run/containers/storage";
    };

    docker = {
      enable = true;
      enableNvidia = true;
      storageDriver = "btrfs";
    };
  };
  
  # good
  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  # programs
  environment.systemPackages = with pkgs; [
    nano # simple text editor
    busybox # pciutils, usbutils, wget. not sure if i want all of these features
    curl # curl
    tree # directory tree
    kubo # ipfs
    direnv # direnv (https://direnv.net/)  load and unload environment variables depending on the current directory.
    jq # json stuff
    cachix # nix cache
    nmap # map network
    gptfdisk # format gpt disk
    kubectl # manage cukernetes
    glances # system monitor
    alejandra # nix formater
    podman-compose
    code-server
  ];
}
