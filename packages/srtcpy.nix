{ writeShellApplication }:
writeShellApplication {
  name = "srtcpy";
  text = builtins.readFile ./srtcpy.sh;
}
# see https://hackage.haskell.org/package/subtitleParser
