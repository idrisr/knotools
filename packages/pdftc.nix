{ writeShellApplication, pdftk, ripgrep, gnused }:
writeShellApplication {
  runtimeInputs = [ pdftk ripgrep gnused ];
  name = "pdftc";
  text = builtins.readFile ./pdftc.sh;
}
