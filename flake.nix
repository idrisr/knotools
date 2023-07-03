{
  inputs.nixpkgs.url = "nixpkgs";
  description = "yo";
  outputs = inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs { system = system; };
      seder = import ./seder.nix pkgs;
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
