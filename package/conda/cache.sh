#!/bin/sh
set -e
root_prefix=$(mktemp -d)

cleanup() {
echo "Removing $root_prefix"
rm -rf "$root_prefix"
}

trap cleanup EXIT

micromamba create -n warmup --dry-run -y -v -c conda-forge python  --root-prefix "$root_prefix" 
tree "$root_prefix"

tar -czvf cache.tar.gz -C "$root_prefix" .
