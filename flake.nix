{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    # flake-utils.lib.eachDefaultSystem (system:
    let
      system = flake-utils.lib.system.x86_64-linux;
      pkgs = nixpkgs.legacyPackages.${system};

      outputSet = pkgs:
        with pkgs; rec {
          awscost = callPackage ./packages/awscost.nix { };
          booknote = callPackage ./packages/booknote.nix { inherit pdftc; };
          epubthumb = callPackage ./packages/epubthumb.nix { };
          mdtopdf = callPackage ./packages/mdtopdf.nix { };
          newcover = haskell.packages.ghc948.callCabal2nix "" ./newcover { };
          pdftc = callPackage ./packages/pdftc.nix { };
          roamamer = callPackage ./packages/roamamer.nix { };
          seder = callPackage ./packages/seder.nix { };
          transcribe = callPackage ./packages/transcribe.nix { };
        };

    in {
      devShells.${system}.default = pkgs.callPackage ./devenv.nix { };
      checks.${system} = outputSet pkgs;
      packages.${system} = outputSet pkgs;
      overlays = { all = final: prev: outputSet prev; };
    };
}
