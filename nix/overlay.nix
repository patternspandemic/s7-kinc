{}:
final: prev:
{
  s7kinc = prev.callPackage ./s7kinc.nix {};
  s7kincDevelop = prev.callPackage ./s7kinc.nix { releaseBuild = false; };
}
