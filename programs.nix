{pkgs, ...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
  };
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
    microsoft-edge # todo: figure out how to only install on ui
    vscode
    logseq # notes
    zotero # more notes!
    devbox
  ];
}
