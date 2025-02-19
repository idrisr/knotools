{ writeShellApplication }:
writeShellApplication {
  name = "srtcpy";
  runtimeInputs = [ ];
  text = builtins.readFile ./srtclean.sh;
}
