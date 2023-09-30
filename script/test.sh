#!/bin/sh

rm modular.qcow2
nixos-rebuild build-vm --flake .#modular
QEMU_NET_OPTS="hostfwd=tcp::2222-:22" ./result/bin/run-modular-vm 