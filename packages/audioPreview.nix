{ writeShellApplication, ffmpeg-headless, html2text }:
writeShellApplication {
  name = "audioPreview";
  runtimeInputs = [ ffmpeg-headless html2text ];
  text = builtins.readFile ./audioPreview.sh;
}
