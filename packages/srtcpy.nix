{ writeShellApplication }:
writeShellApplication {
  name = "srtcpy";
  text = builtins.readFile ./srtcpy.sh;
}
