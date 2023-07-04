{
  inputs.nixpkgs.url = "nixpkgs";
  description = "yo";
  outputs = inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs { system = system; };
    in {
      apps.${system} = { };
      overlays = {
        dimensions = import ./dimensions.nix;
        mdtopdf = import ./mdtopdf.nix;
        newcover = import ./newcover.nix;
        # roamamer = import ./roamamer.nix;
        seder = import ./seder.nix;
        transcribe = import ./transcribe.nix;
      };
    };
}
