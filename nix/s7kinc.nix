{ stdenv, lib, cpio

# Core dependencies:
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

# Switches for the generated s7 configuration header:
, disableDeprecated ? true
, haveComplexNumbers ? true
, haveComplexTrig ? true
#, withCLoader ? true # TODO: Remove withCLoader option, it's required.
, withExtraExponentMarkers ? false
, withGmp ? true
, withImmutableUnquote ? false # TODO: Maybe enforce false.
, withMultithreadChecks ? false
, withPureS7 ? false # TODO: Maybe enforce false.
#, withSystemExtras ? true # TODO: Remove withSystemExtras option, its required.
, s7Debugging ? false

# Names of extra .scm files to include from the s7 distribution not already included below:
, extraS7SchemeFiles ? []

# Name of the compiled binary:
, binName ? "s7-kinc"
}:

let
  # TODO: Add library switches for the lib*.scm so dep libs are included.
  # These files will be included in the output, and accessible via *load-path*.
  s7SchemeFiles = [
    #"case"
    "cload"
    "debug"
    #"json"
    "libc"
    #"libdl"
    #"libgdbm"
    #"libgsl"
    "libm"
    #"libutf8proc"
    "lint"
    #"loop"
    #"mockery"
    #"profile"
    #"r7rs"
    #"reactive"
    #"stuff"
    # "write"
    # TODO: Stuff in tools?
  ] ++ extraS7SchemeFiles;

  otherLibs = [ gdb kode.libKinc ]; #gdbm gsl pkg-config utf8proc
  multiPrecisionLibs = [ gmp gmp.dev libmpc mpfr mpfr.dev ];

  gmpLdOpts = "-lgmp -lmpc -lmpfr";

  toDefineVal = b: if !b then "0" else "1";
in
  stdenv.mkDerivation {
    name = binName; # or, pname & version (how to extract from s7.h?)
    src = ../source;

    buildInputs = otherLibs ++ (lib.optionals withGmp multiPrecisionLibs);
    nativeBuildInputs = [ cpio ];

    buildPhase = with lib; ''
      # Create the s7 configuration header.
      cat << EOF > ./lib/s7/mus-config.h
#define DISABLE_DEPRECATED ${toDefineVal disableDeprecated}
#define HAVE_COMPLEX_NUMBERS ${toDefineVal haveComplexNumbers}
#define HAVE_COMPLEX_TRIG ${toDefineVal haveComplexTrig}
#define WITH_C_LOADER 1
#define WITH_EXTRA_EXPONENT_MARKERS ${toDefineVal withExtraExponentMarkers}
#define WITH_GMP ${toDefineVal withGmp}
#define WITH_IMMUTABLE_UNQUOTE ${toDefineVal withImmutableUnquote}
#define WITH_MULTITHREAD_CHECKS ${toDefineVal withMultithreadChecks}
#define WITH_PURE_S7 ${toDefineVal withPureS7}
#define WITH_SYSTEM_EXTRAS 1
#define S7_DEBUGGING ${toDefineVal s7Debugging}
EOF

      # Inject load paths into s7kinc's core.h. These are used in non-develop mode.
      substituteInPlace s7kinc/core.h \
        --replace "S7_PATH" "S7_PATH \"${builtins.placeholder "out"}/s7kinc/s7\"" \
        --replace "CLOAD_PATH" "CLOAD_PATH \"${builtins.placeholder "out"}/s7kinc/cload\"" \
        --replace "SCHEME_PATH" "SCHEME_PATH \"${builtins.placeholder "out"}/s7kinc/scheme\""

      # Copy s7 sources into s7-kinc tree where its expected. Allow in place overrides.
      cp --no-clobber ${s7}/s7/s7.{h,c} ./lib/s7/
      cp --no-clobber ${s7}/s7/{${concatStringsSep "," s7SchemeFiles}}.scm ./lib/s7/

      # Build the s7-kinc program.
      gcc -o ${binName} main.c s7kinc/core.c s7kinc/repl.c lib/sds/sds.c lib/s7/s7.c -O2 -g -Wl,-export-dynamic -ldl -lm ${lib.optionalString withGmp gmpLdOpts} -lKinc

      # Use s7i to pre-compile shared libraries for included lib/s7/lib*.scm
      pushd lib/s7/
      for s7lib in ${concatMapStringsSep " " (n: n + ".scm") (filter (f: hasPrefix "lib" f) s7SchemeFiles)}
      do
        ${s7}/bin/s7i $s7lib
      done
      popd

      # Do the same for the s7kinc bindings. Make sure to use the cload from
      # lib/s7 in case of override. The s7 header is required due to the
      # generated .c file using "s7.h" over "<s7.h>".
      pushd scheme/kinc/
      cp ../../lib/s7/{cload.scm,s7.h} .
      find . -type f -name "*.scm" -exec ${s7}/bin/s7i '{}' \;
      popd

      # TODO: Pre-compile all 'other' files which make use of cload in scheme/
      #       Use a naming convention like 'lib*.scm' ? or just run every .scm
      #       file through s7i to potentially generate a .so?
    '';

    installPhase = ''
      mkdir -p $out/bin $out/s7kinc/s7 $out/s7kinc/cload $out/s7kinc/scheme

      # Required s7 items
      cp -r lib/s7/* $out/s7kinc/s7
      ln -s $out/s7kinc/s7/{*.c,*.so} $out/s7kinc/cload

      # Precompiled s7 kinc bindings
      pushd scheme/kinc/
      find . -type f -name "kinc_*_s7.*" -print0 | cpio -pdm0 $out/s7kinc/cload
      popd

      # TODO: cpio pre-compiled 'other' .c,.so into cload

      # Project .scm files
      pushd scheme/
      #find . -type f -name "*.scm" -not -path "./kinc/*" -print0 | cpio -pdm0 $out/s7kinc/scheme
      find . -type f -name "*.scm" -print0 | cpio -pdm0 $out/s7kinc/scheme
      popd

      # The binary itself
      cp ${binName} $out/s7kinc
      ln -s $out/s7kinc/${binName} $out/bin
    '';

    meta = with lib; {
      description = "s7-kinc";
      homepage = https://github.com/patternspandemic/s7-kinc/;
      downloadPage = https://github.com/patternspandemic/s7-kinc/;
      license = licenses.unlicense;
      maintainers = [ maintainers.patternspandemic ];
      platforms = [ "x86_64-linux" ];
    };
  }
