{
  inputs.nixpkgs.url = "nixpkgs";
  description = "yo";
  outputs = { nixpkgs, self, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        overlays = with self.overlays; [
          awscost
          booknote
          dimensions
          epubthumb
          mdtopdf
          newcover
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
    in {
      apps.${system} = with pkgs; {
        awscost = mkApp awscost;
        booknote = mkApp booknote;
        dimensions = mkApp dimensions;
        epubthumb = mkApp epubthumb;
        mdtopdf = mkApp mdtopdf;
        newcover = mkApp newcover;
        pdftc = mkApp pdftc;
        roamamer = mkApp roamamer;
        seder = mkApp seder;
        transcribe = mkApp transcribe;
      };
      overlays = {
        awscost = import ./packages/awscost.nix;
        booknote = import ./packages/booknote.nix;
        dimensions = import ./packages/dimensions.nix;
        epubthumb = import ./packages/epubthumb.nix;
        mdtopdf = import ./packages/mdtopdf.nix;
        newcover = import ./packages/newcover.nix;
        pdftc = import ./packages/pdftc.nix;
        roamamer = import ./packages/roamamer.nix;
        seder = import ./packages/seder.nix;
        transcribe = import ./packages/transcribe.nix;
      };
    };
}
