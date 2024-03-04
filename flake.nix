{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/23.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = { nixpkgs, self, flake-utils }:
    let
      system = flake-utils.lib.system.x86_64-linux;
      compiler = "ghc948";
      hPkgs = pkgs.haskell.packages."${compiler}";
      devTools = with pkgs; [
        zlib
        cabal2nix
        imagemagick
        asciinema-agg
        asciinema
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
        pkgs.zlib
        pkgs.cabal2nix
      ];

      tools = devTools ++ haskDevTools;

      pkgs = import nixpkgs {
        overlays = with self.overlays; [
          awscost
          booknote
          epubthumb
          mdtopdf
          pdftc
          roamamer
          seder
          transcribe
        ];
        inherit system;
        config = { allowUnfree = true; };
      };

      mkApp = p:
        let name = pkgs.lib.getName p;
        in {
          type = "app";
          program = "${p}/bin/${name}";
        };
      newcover2 = with pkgs; haskell.packages.${compiler}.callPackage ./. { };
    in {
      apps.${system} = with pkgs; {
        awscost = mkApp awscost;
        booknote = mkApp booknote;
        epubthumb = mkApp epubthumb;
        mdtopdf = mkApp mdtopdf;
        pdftc = mkApp pdftc;
        roamamer = mkApp roamamer;
        seder = mkApp seder;
        transcribe = mkApp transcribe;
      };

      overlays = {
        awscost = import ./packages/awscost.nix;
        booknote = import ./packages/booknote.nix;
        epubthumb = import ./packages/epubthumb.nix;
        mdtopdf = import ./packages/mdtopdf.nix;
        newcover = import ./packages/newcover.nix newcover2;
        pdftc = import ./packages/pdftc.nix;
        roamamer = import ./packages/roamamer.nix;
        seder = import ./packages/seder.nix;
        transcribe = import ./packages/transcribe.nix;
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = tools;
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath tools;
      };

      packages.${system}.default = newcover2;
    };
}
