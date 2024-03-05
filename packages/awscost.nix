{ writeShellApplication, awscli, jq, coreutils }:
writeShellApplication {
  name = "awscost";
  runtimeInputs = [ awscli jq coreutils ];
  text = builtins.readFile ./awscost.sh;
}
