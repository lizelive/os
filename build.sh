#!/bin/sh
nix-shell -p nixos-generators --run 'nixos-generate -f iso -c configuration.nix --out-link out'
sudo dd if=./out/iso/nixos.iso of=/dev/sdc status=progress
sudo sync
