final: prev: {
  transcribe = prev.writeShellApplication {
    name = "transcribe";
    runtimeInputs = with prev; [ tesseract5 poppler_utils ];
    text = builtins.readFile ./transcribe.sh;
  };
}
