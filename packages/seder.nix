final: prev: {
  seder = prev.writeShellApplication {
    name = "seder";
    runtimeInputs = [ prev.pdftk ];
    text = builtins.readFile ./seder.sh;
  };
}
