{
  inputs.nixpkgs.url = "nixpkgs";
  description = "yo";
  outputs = { nixpkgs, self, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        overlays = [
          self.overlays.booknote
          self.overlays.dimensions
          self.overlays.mdtopdf
          self.overlays.newcover
          self.overlays.pdftc
          self.overlays.roamamer
          self.overlays.seder
          self.overlays.transcribe
        ];
        system = system;
        config = { allowUnfree = true; };
      };
    in {
      apps.${system} = with pkgs; {
        booknote = {
          type = "app";
          program = "${booknote}/bin/booknote";
        };
        dimensions = {
          type = "app";
          program = "${dimensions}/bin/dimensions";
        };
        mdtopdf = {
          type = "app";
          program = "${mdtopdf}/bin/mdtopdf";
        };
        newcover = {
          type = "app";
          program = "${newcover}/bin/newcover";
        };
        pdftc = {
          type = "app";
          program = "${pdftc}/bin/pdftc";
        };
        roamamer = {
          type = "app";
          program = "${roamamer}/bin/roamamer";
        };
        seder = {
          type = "app";
          program = "${seder}/bin/seder";
        };
        transcribe = {
          type = "app";
          program = "${transcribe}/bin/transcribe";
        };
      };
      overlays = {
        booknote = import ./booknote.nix;
        dimensions = import ./dimensions.nix;
        mdtopdf = import ./mdtopdf.nix;
        newcover = import ./newcover.nix;
        pdftc = import ./pdftc.nix;
        roamamer = import ./roamamer.nix;
        seder = import ./seder.nix;
        transcribe = import ./transcribe.nix;
      };
    };
}
