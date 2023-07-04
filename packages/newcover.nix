final: prev: {
  newcover = prev.writeShellApplication {
    name = "newcover";

    runtimeInputs = with prev; [ wget dimensions pdftk imagemagick ];
    text = builtins.readFile ./newcover.sh;
  };
}
