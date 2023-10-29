{ pkgs, ... }: {
  # programs
  environment.systemPackages = with pkgs; [
    chromium # browser
    (vscode-with-extensions.override {
      # vscode = vscodium;
      vscodeExtensions = with vscode-extensions; [
        vadimcn.vscode-lldb
        timonwong.shellcheck
        tamasfe.even-better-toml
        serayuzgur.crates
        rust-lang.rust-analyzer
        redhat.vscode-yaml
        ms-vscode-remote.remote-containers
        ms-vscode-remote.remote-ssh
        ms-python.python
        ms-azuretools.vscode-docker
        mkhl.direnv
        jnoortheen.nix-ide
        james-yu.latex-workshop
        github.copilot-chat
        github.copilot
      ];
    })
    nil # nix code server . compared with rnix-lsp and nixd . this was the best

    texlive.combined.scheme-full # latex

    logseq # notes
    zotero # more notes!
    blender # 3d modeling and video editing
    obs-studio # streaming
    bitwarden # password
  ];
}
