{ pkgs, ... }:
let compiler = "ghc96";
in {
  packages = with pkgs.haskell.packages."${compiler}"; [
    fourmolu
    cabal-fmt
    implicit-hie
    ghcid
  ];

  languages.haskell.enable = true;
}
