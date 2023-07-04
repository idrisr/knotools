final: prev: {
  seder = final.writeShellApplication {
    name = "seder";
    runtimeInputs = [ pdftk ];
    text = builtins.readFile ./seder.sh;
  };
}
