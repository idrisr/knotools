final: prev: rec {
  pdftc = prev.callPackage ./packages/pdftc.nix { };
  awscost = prev.callPackage ./packages/awscost.nix { };
  booknote = prev.callPackage ./packages/booknote.nix { inherit pdftc; };
  epubthumb = prev.callPackage ./packages/epubthumb.nix { };
  mdtopdf = prev.callPackage ./packages/mdtopdf.nix { };
  roamamer = prev.callPackage ./packages/roamamer.nix { };
  seder = prev.callPackage ./packages/seder.nix { };
  transcribe = prev.callPackage ./packages/transcribe.nix { };
}
