pkgs:
with pkgs;
writeShellApplication {
  name = "seder";
  runtimeInputs = with pkgs; [ pdftk ];
  text = builtins.readFile ./seder.sh;
}
