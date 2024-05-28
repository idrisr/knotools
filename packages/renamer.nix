{ stdenvNoCC, neovim, pipe-rename, makeWrapper }:

stdenvNoCC.mkDerivation {
  name = "pipe-renamer";
  dontUnpack = true;
  nativeBuildInputs = [ makeWrapper neovim pipe-rename ];
  installPhase = ''
    mkdir -p "$out/bin"
    cp ${pipe-rename}/bin/renamer $out/bin/renamer
    wrapProgam $out/bin/renamer --add-flags "--editor=neovim --clean"
  '';
}
