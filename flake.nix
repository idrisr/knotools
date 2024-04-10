{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, self, flake-utils }:
    # flake-utils.lib.eachDefaultSystem (system:
    let
      compiler = "ghc948";
      system = flake-utils.lib.system.x86_64-linux;
      hPkgs = pkgs.haskell.packages."${compiler}";
      devTools = with pkgs; [
        asciinema
        asciinema-agg
        cabal2nix
        imagemagick
        zlib
      ];

      haskDevTools = with hPkgs; [
        ghc
        ghcid
        fourmolu
        hlint
        haskell-language-server
        implicit-hie
        retrie
        cabal-install
      ];

      tools = devTools ++ haskDevTools;

      pkgs = import nixpkgs {
        inherit system;
        overlays = [ self.overlays.all ];
      };

    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = tools;
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath tools;
      };

      packages.${system} = with pkgs; {
        inherit awscost;
        inherit booknote;
        inherit epubthumb;
        inherit mdtopdf;
        inherit newcover;
        inherit pdftc;
        inherit roamamer;
        inherit seder;
        inherit transcribe;
      };

      overlays = {
        all = final: prev: {
          awscost = prev.callPackage ./packages/awscost.nix { };
          booknote = prev.callPackage ./packages/booknote.nix { };
          epubthumb = prev.callPackage ./packages/epubthumb.nix { };
          mdtopdf = prev.callPackage ./packages/mdtopdf.nix { };
          newcover = prev.haskell.packages.${compiler}.callPackage ./. { };
          pdftc = prev.callPackage ./packages/pdftc.nix { };
          roamamer = prev.callPackage ./packages/roamamer.nix { };
          seder = prev.callPackage ./packages/seder.nix { };
          transcribe = prev.callPackage ./packages/transcribe.nix { };
        };
      };
    };
}
