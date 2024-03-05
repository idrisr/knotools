{ writeShellApplication, python39 }:
writeShellApplication {
  name = "epubthumb";
  runtimeInputs = [
    (python39.withPackages (pythonPackages: with pythonPackages; [ pillow ]))
  ];
  text = ''
    python ${./epubthumb.py} "$@"
  '';
}
