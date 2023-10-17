{pkgs, ...}: {
  # programs
  environment.systemPackages = with pkgs; [
    microsoft-edge # todo: figure out how to only install on ui
    logseq # notes
    zotero # more notes!
    blender # crime
  ];
}
