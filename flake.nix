{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/24.05";
    flake-utils.url = "github:numtide/flake-utils";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    devenv.url = "github:cachix/devenv";
  };

  outputs = inputs@{ nixpkgs, ... }:
    let
      system = inputs.flake-utils.lib.system.x86_64-linux;
      pkgs = nixpkgs.legacyPackages.${system};
      hooks = {
        nixfmt.enable = true;
        deadnix.enable = true;
        beautysh.enable = true;
      };

      pipe-rename = _: prev: {
        pipe-rename = with prev;
          stdenvNoCC.mkDerivation {
            name = "pipe-rename";
            pname = "pipe-rename";
            dontUnpack = true;
            nativeBuildInputs = [ makeWrapper ];
            installPhase = ''
              mkdir -p "$out/bin"
              cp ${prev.pipe-rename}/bin/renamer $out/bin/renamer
              wrapProgram $out/bin/renamer --add-flags "--editor='${prev.neovim}/bin/nvim --clean'"
            '';
          };
      };

      outputSet = pkgs:
        with pkgs; rec {
          audioPreview = callPackage ./packages/audioPreview.nix { };
          awscost = callPackage ./packages/awscost.nix { };
          booknote = callPackage ./packages/booknote.nix { inherit pdftc; };
          mdtopdf = callPackage ./packages/mdtopdf.nix { };
          newcover = haskell.packages.ghc948.callCabal2nix "" ./newcover { };
          videoChapter =
            haskell.packages.ghc96.callCabal2nix "" ./videoChapter { };
          pdftc = callPackage ./packages/pdftc.nix { };
          seder = callPackage ./packages/seder.nix { };
          srtcpy = callPackage ./packages/srtcpy.nix { };
          transcribe = callPackage ./packages/transcribe.nix { };
          vttclean = haskell.packages.ghc965.callCabal2nix "" ./vttclean { };
        };

    in {
      devShells.${system}.default = inputs.devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [{ pre-commit.hooks = hooks; }];
      };

      checks.${system} = {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          inherit hooks;
        };
      } // outputSet pkgs;

      packages.${system} = outputSet pkgs;
      overlays = {
        all = _: prev: outputSet prev;
        inherit pipe-rename;
      };
    };
}
