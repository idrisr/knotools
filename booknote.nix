final: prev: {
  booknote = prev.writeShellApplication {
    name = "booknote";
    runtimeInputs = [ final.pdftc ];
    text = builtins.readFile ./booknote.sh;
  };
}
