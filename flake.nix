{
  inputs.nixpkgs.url = "nixpkgs";
  description = "yo";
  outputs = { nixpkgs, self, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        overlays = with self.overlays; [
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
        booknote = import ./booknote.nix;
        dimensions = import ./dimensions.nix;
        epubthumb = import ./epubthumb.nix;
        mdtopdf = import ./mdtopdf.nix;
        newcover = import ./newcover.nix;
        pdftc = import ./pdftc.nix;
        roamamer = import ./roamamer.nix;
        seder = import ./seder.nix;
        transcribe = import ./transcribe.nix;
      };
    };
}
