{ writeShellApplication, tesseract5, poppler_utils }:
writeShellApplication {
  name = "transcribe";
  runtimeInputs = [ tesseract5 poppler_utils ];
  text = builtins.readFile ./transcribe.sh;
}
