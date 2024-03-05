{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/23.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { nixpkgs, self, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        compiler = "ghc948";
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
          config = { allowUnfree = true; };
        };

        pdftc = pkgs.callPackage ./packages/pdftc.nix { };
        awscost = pkgs.callPackage ./packages/awscost.nix { };
        booknote = pkgs.callPackage ./packages/booknote.nix { inherit pdftc; };
        epubthumb = pkgs.callPackage ./packages/epubthumb.nix { };
        mdtopdf = pkgs.callPackage ./packages/mdtopdf.nix { };
        roamamer = pkgs.callPackage ./packages/roamamer.nix { };
        seder = pkgs.callPackage ./packages/seder.nix { };
        transcribe = pkgs.callPackage ./packages/transcribe.nix { };

        mkApp = p:
          let name = pkgs.lib.getName p;
          in {
            type = "app";
            program = "${p}/bin/${name}";
          };
        newcover2 = with pkgs; haskell.packages.${compiler}.callPackage ./. { };

      in {
        apps = {
          awscost = mkApp awscost;
          booknote = mkApp booknote;
          epubthumb = mkApp epubthumb;
          mdtopdf = mkApp mdtopdf;
          pdftc = mkApp pdftc;
          roamamer = mkApp roamamer;
          seder = mkApp seder;
          transcribe = mkApp transcribe;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = tools;
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath tools;
        };

        packages.default = newcover2;
      });
}
