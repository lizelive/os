{pkgs, ...}: {
  # programs
  environment.systemPackages = with pkgs; [
    firefox
    vscodium
    logseq # notes
    zotero # more notes!
    blender # 3d modeling and video editing
    obs-studio # streaming
    bitwarden # password
  ];
}
