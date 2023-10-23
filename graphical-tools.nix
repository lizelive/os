{pkgs, ...}: {
  # programs
  environment.systemPackages = with pkgs; [
    firefox
    (vscode-with-extensions.override {
      vscode = vscodium;
      vscodeExtensions = with vscode-extensions; [
        vadimcn.vscode-lldb
        tamasfe.even-better-toml
        serayuzgur.crates
        rust-lang.rust-analyzer
        ms-python.python
        mkhl.direnv
        jnoortheen.nix-ide
        github.copilot-chat
        github.copilot
      ];
    })
    logseq # notes
    zotero # more notes!
    blender # 3d modeling and video editing
    obs-studio # streaming
    bitwarden # password
  ];
}
