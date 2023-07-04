final: prev: {
  epubthumb = final.writeShellApplication {
    name = "epubthumb";
    runtimeInputs = [
      (prev.pkgs.python39.withPackages
        (pythonPackages: with pythonPackages; [ pillow ]))
    ];
    text = ''
      python ${./epubthumb.py} "$@"
    '';
  };
}
