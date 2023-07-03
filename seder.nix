pkgs:
with pkgs;
writeShellApplication {
  name = "seder";
  runtimeInputs = [ pdftk ];
  text = builtins.readFile ./seder.sh;
}
