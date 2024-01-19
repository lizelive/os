{ pkgs, ... }: {
  # programs
  environment.systemPackages = with pkgs; [
    fluidsynth # midi
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
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-containers
        ms-python.vscode-pylance
        ms-python.python
        ms-dotnettools.csharp
        ms-azuretools.vscode-docker
        mkhl.direnv
        jnoortheen.nix-ide
        james-yu.latex-workshop
        github.copilot-chat
        github.copilot
      ];
    })
    # vscode
    # nix code server
    # rnix-lsp # no longer mantained
    nil # 825 stars, writen in rust
    # nixd # 400 stars, in theory has better document support, did not work

    texlive.combined.scheme-full # latex

    logseq # notes
    zotero # more notes!
    blender # 3d modeling and video editing
    obs-studio # streaming
    bitwarden # password
    krita
  ];
}
