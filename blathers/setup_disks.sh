#!/bin/bash
nvmes=$(ls /dev/nvme*n1)

boot_device='/dev/disk/by-path/pci-0000:04:00.3-usb-0:3:1.0-scsi-0:0:0:0'
 
mkfs.btrfs --csum xxhash --data raid0 --metadata raid0 --label blathers-nvmes /dev/nvme1n1

# setup boot device
printf "label: gpt\n,550M,U\n,,L\n" | sfdisk $boot_device
mkfs.fat -F 32 "$boot_device-part1"
mount "$boot_device-part1" /boot

mount /dev/disk/by-label/blathers-nvmes /mnt
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/nix
btrfs subvolume create /mnt/log # create log subvolume
btrfs subvolume create /mnt/cache # create cache subvolume
btrfs subvolume create /mnt/data # create data subvolume

umount /mnt
mount -o compress=zstd,subvol=root /dev/disk/by-label/blathers-nvmes /mnt
mkdir /mnt/{boot,home,nix,var,var/cache,var/log}
mount -o compress=zstd,subvol=home /dev/disk/by-label/blathers-nvmes /mnt/home
mount -o compress=zstd,subvol=cache /dev/disk/by-label/blathers-nvmes /mnt/var/cache
mount -o compress=zstd,subvol=log /dev/disk/by-label/blathers-nvmes /mnt/var/log
mount -o compress=zstd,noatime,subvol=nix /dev/disk/by-label/blathers-nvmes /mnt/nix