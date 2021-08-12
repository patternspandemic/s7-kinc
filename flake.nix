{
  description = "Kinc and s7 Scheme bound together.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    flake-utils.url = "github:numtide/flake-utils";
    s7-flk.url = "github:patternspandemic/s7-flake";
    kode-flk.url = "github:patternspandemic/kode-flake";
  };

  outputs = { self, nixpkgs, flake-utils, s7-flk, kode-flk }:
    {
      overlay = import ./nix/overlay.nix {};
    }
    //
    (
      flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config = {
            #   #allowBroken = true;
              allowUnfree = true;
            };
            overlays = [
              self.overlay
              s7-flk.overlay
              kode-flk.overlay
            ];
          };
        in rec
        {

          packages = flake-utils.lib.flattenTree { s7kinc = pkgs.s7kinc; };

          # TODO: Define an emvvar specifying a dev mode, which will end up hiding precompiled .so and adding local paths to load path.
          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [ s7kinc s7 kode.libKinc ];
            #inputsFrom = builtins.attrValues self.packages.${system};
            shellHook = ''
             echo Welcome to s7-Kinc!
            '';
          };

        }
      )
    );
}
