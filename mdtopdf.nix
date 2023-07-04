final: prev: {
  mdtopdf = prev.writeShellApplication {
    name = "mdtopdf";
    runtimeInputs = with prev; [ pandoc texlive.combined.scheme-full ];
    text = builtins.readFile ./mdtopdf.sh;
  };
}
