{ writeShellApplication, git, gnused }:
writeShellApplication {
  name = "roamamer";
  runtimeInputs = [ git gnused ];
  text = builtins.readFile ./roamamer.sh;
}
