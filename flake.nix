{
  description = "Kinc and s7 Scheme bound together.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    flake-utils.url = "github:numtide/flake-utils";
    s7-flk.url = "github:patternspandemic/s7-flake";

    #local override of s7 source
#    s7-flk.inputs.s7-src = { url = "path:../s7";
#                             flake = false; };

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

          packages = flake-utils.lib.flattenTree { s7kinc = pkgs.s7kinc; s7kincDevelop = pkgs.s7kincDevelop; };

          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [ s7kincDevelop s7 kode.libKinc kode.krafix ];
            #inputsFrom = builtins.attrValues self.packages.${system};
            S7KINC_DEV_SHELL = "1";
            S7KINC_DEV_ROOT = "/home/pattern/repos/s7-kinc";
            #shellHook = '''';
          };

        }
      )
    );
}
