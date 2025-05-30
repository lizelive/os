{
  settings = {
    editor.inlineSuggest.enabled = true;
    nix.enableLanguageServer = true;
  };
  extensions =
    e: with e; [
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
}
