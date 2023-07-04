{
  inputs.nixpkgs.url = "nixpkgs";
  description = "yo";
  outputs = inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs { system = system; };
      seder = with pkgs;
        writeShellApplication {
          name = "seder";
          runtimeInputs = [ pdftk ];
          text = builtins.readFile ./seder.sh;
        };
    in {
      apps.${system} = {
        seder = {
          type = "app";
          program = "${seder}/bin/seder";
        };
        default = seder;
      };
      packages.${system} = {
        inherit seder;
        default = seder;
      };
      overlays.default = final: prev: { inherit seder; };
    };
}
