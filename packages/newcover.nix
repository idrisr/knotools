newcover2: final: prev: {
  newcover = prev.writeShellApplication {
    name = "newcover";
    runtimeInputs = with prev; [ wget newcover2 pdftk imagemagick ];
    text = ''
      exec newcover "$@"
    '';
  };
}
