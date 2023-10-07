{pkgs, ...}: {
  # use podman
  virtualisation = {
    docker = {
      enable = true;
      enableNvidia = true;
    };
  };
  
  # good
  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  # direnv (https://direnv.net/)  load and unload environment variables depending on the current directory.
  programs.direnv.enable = true;

  # programs
  environment.systemPackages = with pkgs; [
    nano # simple text editor
    busybox # pciutils, usbutils, wget. not sure if i want all of these features
    curl # curl
    tree # directory tree
    kubo # ipfs
    jq # json stuff
    cachix # nix cache
    nmap # map network
    gptfdisk # format gpt disk
    kubectl # manage cukernetes
    glances # system monitor
    alejandra # nix formater
    vscode # offical vscode
    micromamba # nice to have
    file
  ];
}
