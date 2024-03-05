{ writeShellApplication, pandoc, texlive }:
writeShellApplication {
  name = "mdtopdf";
  runtimeInputs = [ pandoc texlive.combined.scheme-full ];
  text = builtins.readFile ./mdtopdf.sh;
}
