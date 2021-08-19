{
  description = "Kinc and s7 Scheme bound together.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
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

          packages = flake-utils.lib.flattenTree { s7kinc = pkgs.s7kinc; };

          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [ s7kinc s7 kode.libKinc ];
            #inputsFrom = builtins.attrValues self.packages.${system};
            S7KINC_DEV_SHELL = "1";
            # Or, just have s7-kinc look for this envvar?
            S7KINC_DEV_PATH = "/home/pattern/repos/s7-kinc/source";
            #shellHook = '''';
          };

        }
      )
    );
}
