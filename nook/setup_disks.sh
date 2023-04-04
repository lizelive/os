#!/bin/bash


hdds=$(ls /dev/disk/by-id/ata*)
mkfs.btrfs --csum xxhash --data raid10 --label nook-hdds --force $hdds

# setup boot device
# printf "label: gpt\n,550M,U\n,,L\n" | sfdisk boot_device

mount -o compress=zstd,noatime /dev/disk/by-label/nook-hdds /mnt/hdds

umount /mnt
mount -o compress=zstd,subvol=root /dev/disk/by-label/blathers-nvmes /mnt
mkdir /mnt/{boot,home,nix,var,var/cache,var/log}
mount -o compress=zstd,subvol=home /dev/disk/by-label/blathers-nvmes /mnt/home
mount -o compress=zstd,subvol=cache /dev/disk/by-label/blathers-nvmes /mnt/var/cache
mount -o compress=zstd,subvol=log /dev/disk/by-label/blathers-nvmes /mnt/var/log
mount -o compress=zstd,noatime,subvol=nix /dev/disk/by-label/blathers-nvmes /mnt/nix