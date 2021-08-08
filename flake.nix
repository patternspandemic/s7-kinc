{
  description = "Kinc bindings for s7 Scheme";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    flake-utils.url = "github:numtide/flake-utils";
    s7-flk.url = "github:patternspandemic/s7-flake";
    kode-flk.url = "github:patternspandemic/kode-flake";
  };

  outputs = { self, nixpkgs, flake-utils, s7-flk, kode-flk }:
    #{
    #  overlay = import ./overlay.nix { inherit s7-src s7-man; };
    #}
    #//
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
              s7-flk.overlay
              kode-flk.overlay
            ];
          };
        in rec
        {

          #packages = flake-utils.lib.flattenTree { s7 = pkgs.s7; };

          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [ s7 kode.libKinc ];
            #inputsFrom = builtins.attrValues self.packages.${system};
          };

        }
      )
    );
}
