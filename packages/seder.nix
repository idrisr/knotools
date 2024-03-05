{ writeShellApplication, pdftk, gnused }:
writeShellApplication {
  name = "seder";
  runtimeInputs = [ pdftk gnused ];
  text = builtins.readFile ./seder.sh;
}
