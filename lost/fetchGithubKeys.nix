{ username }:
let
  file = builtins.fetchurl "https://github.com/${username}.keys";
  text = builtins.readFile file;
  lines = builtins.split "\n" text;
  keys = builtins.filter (v: builtins.isString v && v != "") lines;
in
keys
