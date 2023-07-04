final: prev: {
  awscost = with prev;
    writeShellApplication {
      name = "awscost";
      runtimeInputs = [ awscli jq ];
      text = builtins.readFile ./awscost.sh;
    };
}
