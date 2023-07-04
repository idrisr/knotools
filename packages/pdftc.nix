final: prev: {
  pdftc = prev.writeShellApplication {
    name = "pdftc";
    text = builtins.readFile ./pdftc.sh;
  };
}
