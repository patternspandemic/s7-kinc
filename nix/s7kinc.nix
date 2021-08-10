{ stdenv, lib
, s7
, kode
, gdb
#, gdbm
, gmp
#, gsl
, mpfr
, libmpc
#, pkg-config
#, utf8proc
, disableDeprecated ? true
, haveComplexNumbers ? true
, haveComplexTrig ? true
, withCLoader ? true
, withExtraExponentMarkers ? false
, withGmp ? true
, withImmutableUnquote ? false
, withMultithreadChecks ? false
, withPureS7 ? false
, withSystemExtras ? true # TODO: Remove withSystemExtras option?
, s7Debugging ? false
}:

let
  binName = "s7-kinc";
  otherLibs = [ gdb kode.libKinc ]; #gdbm gsl pkg-config utf8proc
  multiPrecisionLibs = [ gmp gmp.dev libmpc mpfr mpfr.dev ];

  gmpLdOpts = "-lgmp -lmpc -lmpfr";

  toDefineVal = b: if !b then "0" else "1";
in
  stdenv.mkDerivation {
    name = "s7-kinc"; # or, pname & version (how to extract from s7.h?)
    src = ../source;

    buildInputs = otherLibs ++ (lib.optionals withGmp multiPrecisionLibs);
    # TODO: propogatedBuildInputes? nativeBuildInputs?

    buildPhase = ''
      # Create the s7 configuration header.
      cat << EOF > ./lib/s7/mus-config.h
#define DISABLE_DEPRECATED ${toDefineVal disableDeprecated}
#define HAVE_COMPLEX_NUMBERS ${toDefineVal haveComplexNumbers}
#define HAVE_COMPLEX_TRIG ${toDefineVal haveComplexTrig}
//#define WITH_C_LOADER ${toDefineVal withCLoader}
#define WITH_EXTRA_EXPONENT_MARKERS ${toDefineVal withExtraExponentMarkers}
#define WITH_GMP ${toDefineVal withGmp}
//#define WITH_IMMUTABLE_UNQUOTE ${toDefineVal withImmutableUnquote}
#define WITH_MULTITHREAD_CHECKS ${toDefineVal withMultithreadChecks}
//#define WITH_PURE_S7 ${toDefineVal withPureS7}
#define WITH_SYSTEM_EXTRAS ${toDefineVal withSystemExtras}
#define S7_DEBUGGING ${toDefineVal s7Debugging}
#define S7_LOAD_PATH "${s7}/s7"
EOF
      # Copy s7 source into s7-kinc tree where its expected.
      # TODO: cp only when non-existant and warn / error?
      cp ${s7}/s7/s7.{h,c} ./lib/s7/

      # Build the s7-kinc program.
      # TODO: Support different program name than s7-kinc
      gcc -o ${binName} main.c s7kinc/core.c s7kinc/repl.c lib/sds/sds.c lib/s7/s7.c -O2 -g -Wl,-export-dynamic -ldl -lm ${lib.optionalString withGmp gmpLdOpts} -lKinc

      # TODO: Use s7i to pre-compile shared libraries for kinc bits
    '';

    installPhase = ''
      mkdir -p $out/bin $out/lib
      cp ${binName} $out/bin
      # TODO: copy *_s7.so to $out/lib
    '';

    meta = with lib; {
      description = "s7kinc";
      homepage = https://github.com/patternspandemic/s7-kinc/;
      downloadPage = https://github.com/patternspandemic/s7-kinc/;
      license = licenses.unlicense;
      maintainers = [ maintainers.patternspandemic ];
      platforms = [ "x86_64-linux" ];
    };
  }
