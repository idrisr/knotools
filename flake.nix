{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.11";
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

      outputSet = pkgs:
        with pkgs; rec {
          awscost = callPackage ./packages/awscost.nix { };
          booknote = callPackage ./packages/booknote.nix { inherit pdftc; };
          mdtopdf = callPackage ./packages/mdtopdf.nix { };
          newcover = haskell.packages.ghc948.callCabal2nix "" ./newcover { };
          pdftc = callPackage ./packages/pdftc.nix { };
          roamamer = callPackage ./packages/roamamer.nix { };
          seder = callPackage ./packages/seder.nix { };
          transcribe = callPackage ./packages/transcribe.nix { };
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
      overlays.all = _: prev: outputSet prev;
    };
}
