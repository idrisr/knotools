{ pkgs, compiler ? "ghc948" }:
let
  hPkgs = pkgs.haskell.packages."${compiler}";
  devTools = with pkgs; [ cabal2nix imagemagick zlib ];
  haskDevTools = with hPkgs; [
    cabal-install
    fourmolu
    ghc
    ghcid
    haskell-language-server
    hlint
    implicit-hie
    retrie
  ];
  tools = devTools ++ haskDevTools;
in pkgs.mkShell {
  buildInputs = tools;
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath tools;
}
