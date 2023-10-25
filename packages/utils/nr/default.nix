{ writeShellApplication }:

writeShellApplication {
  name = "nr";

  text = builtins.readFile ./nr.sh;
}
