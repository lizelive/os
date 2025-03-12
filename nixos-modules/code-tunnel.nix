{ lib, pkgs, config, ... }:
with lib;                      
let
  # Shorter name to access final settings a 
  # user of hello.nix module HAS ACTUALLY SET.
  # cfg is a typical convention.
  cfg = config.services.code-tunnel;
    my-vscode = with pkgs; (vscode-with-extensions.override {
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
    });
    runtimeInputs = with pkgs; [
      bashInteractive

      my-vscode
      nano # simple text editor

      wget # download stuff
      curl # curl

      jq # json stuff
      file # file type cli tool
      tree # directory tree
      glances # system monitor

      nixfmt-rfc-style # format nix
      shfmt # format ssh
      nil # Nix Language server nixd is more powerful but requires configuration
      nix-tree # see tree of nix stuff
      nix-init # init nix project from a repo

      podman # use docker stuff
    ];
in {
  options.services.code-tunnel = {
    enable = mkEnableOption "Visual Studio Code Tunnel";
    # cli-data-dir = mkOption {
    #   type = types.str;
    #   default = "$HOME/.vscode/cli";
    # };
  };
 
  # by setting "services.code-tunnel.enable = true;".
  config = mkIf cfg.enable {
    systemd.user.services.code-tunnel = {
      enable = true;
      after = [ "network.target" ];
      wantedBy = [ "default.target" ];
      description = "Visual Studio Code Tunnel";
      path = [ pkgs.vscode pkgs.bashInteractive pkgs.wget pkgs.git pkgs.podman ];
      # --cli-data-dir ${cfg.cli-data-dir}
      script = "${pkgs.vscode}/lib/vscode/bin/code-tunnel --cli-data-dir $HOME/.vscode/cli tunnel service internal-run";
      serviceConfig = {
          Type = "simple";
          Restart = "always";
          RestartSec = 10;
      };
    };
  };
}
