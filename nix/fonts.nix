{stdenv, ...}:
stdenv.mkDerivation (finalAttrs: {
  pname = "fonts";
  version = "dummy";

  src = ../fonts;
  dontUnpack = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fonts/opentype
    mkdir -p $out/share/fonts/truetype
    install -Dm644 $src/redhat/*.otf -t $out/share/fonts/opentype
    install -Dm644 $src/redhat-vf/*.ttf -t $out/share/fonts/truetype
    runHook postInstall
  '';
})
