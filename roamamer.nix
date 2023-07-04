final: prev: {
  roamamer = prev.writeShellApplication {
    name = "roamamer";

    runtimeInputs = with prev; [ git ];
    text = builtins.readFile ./roamamer.sh;
  };
}
