{ pkgs, config, ... }: {
  # use podman
  # virtualisation = {
  #   docker = {
  #     enable = true;
  #     enableNvidia = true;
  #   };
  # };

  # good
  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  # use zsh as default shell
  # programs.zsh.enable = true;
  # users.defaultUserShell = pkgs.zsh;

  # direnv (https://direnv.net/)  load and unload environment variables depending on the current directory.
  programs.direnv.enable = true;

  # programs
  environment.systemPackages = with pkgs; [
    nano # simple text editor
    # busybox # pciutils, usbutils, wget. not sure if i want all of these features
    wget # download stuff
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
    micromamba # nice to have
    file # file type cli tool
    nixpkgs-fmt # format nix
    shfmt # format ssh
    nix-tree # see tree of nix stuff
  ];


  programs.ccache = {
    enable = true;
    # packageNames = [ "wxGTK32" "ffmpeg" "libav_all" "opencv" "opencv3" "opencv2" "blender" ];
  };
  nix.settings.extra-sandbox-paths = [ config.programs.ccache.cacheDir ];
}
