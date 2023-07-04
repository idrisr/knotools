final: prev: {
  dimensions = prev.writeShellApplication {
    name = "dimensions";

    runtimeInputs = with prev; [ pdftk ripgrep ];
    text = builtins.readFile ./dimensions.sh;
  };
}
