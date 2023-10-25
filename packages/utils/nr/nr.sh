#! /bin/sh

# nr.sh - A shell script to run a program from nix without installing it.

cmd="nix run"

is_flag() {
        case "$1" in
        "-"*) true ;;
        *) false ;;
        esac
}

# while program starts with --, keep shifting
while is_flag "$1"; do
        
        case "$1" in
        "--unfree") cmd="NIXPKGS_ALLOW_UNFREE=1 $cmd --impure" ;;
        *) cmd=cmd="$cmd --$1"  ;;
        esac
        
        shift
done
program=$1
shift
cmd="$cmd nixpkgs#$program -- $*"

eval "$cmd"