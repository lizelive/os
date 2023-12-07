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
        ms-vscode-remote.remote-containers # will be included in 23.11
        ms-vscode-remote.remote-ssh
        ms-python.python
        ms-azuretools.vscode-docker
        mkhl.direnv
        jnoortheen.nix-ide
        james-yu.latex-workshop
        github.copilot-chat # will be included in 23.11
        github.copilot
        ms-python.vscode-pylance
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
    # blender # 3d modeling and video editing
    obs-studio # streaming
    bitwarden # password
  ];
}
