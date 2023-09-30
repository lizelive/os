# curl https://code.visualstudio.com/sha | jq '.products[] | select (.platform.os == "cli-alpine-x64")' >$out
{
  stdenv,
  fetchurl,
  runCommand,
  curl,
  jq,
}: {
  out = runCommand "get-sha-cmd" { buildInputs = [ curl jq ]; } (builtins.readFile ./get_sha.sh);
}

# nix-build -E 'with import <nixpkgs> { }; callPackage ./default.nix { }'