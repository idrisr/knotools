{ writeShellApplication, pdftc }:
writeShellApplication {
  name = "booknote";
  runtimeInputs = [ pdftc ];
  text = builtins.readFile ./booknote.sh;
}
