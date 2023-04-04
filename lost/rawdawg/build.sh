#!/bin/sh
nix-shell -p nixos-generators --run 'nixos-generate -f raw-efi -c configuration.nix --out-link out'
sudo dd if=./out/iso/nixos*.iso of=/dev/sdc status=progress
# sudo dd if=./out/nixos.img of=/dev/sdc status=progress
sudo sync
