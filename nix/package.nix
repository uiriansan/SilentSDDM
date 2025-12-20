{
  lib,
  callPackage,
  stdenvNoCC,
  kdePackages,
  gitRev ? "unknown",
  theme ? "default",
  theme-overrides ? {},
  extraBackgrounds ? [],
}:
stdenvNoCC.mkDerivation (final: let
  inherit (lib) attrValues substring concatStringsSep map any;
  inherit (lib.generators) toINI;
  inherit (lib.fileset) toSource difference unions fileFilter;
in {
  pname = "silent";
  version = "${substring 0 8 gitRev}";

  # cleanly select only the pieces of source that **building** this package depends on.
  # avoids unnecessary rebuilds when unrelated pieces (like the README) changes.
  src = toSource {
    root = ../.;
    fileset = difference ../. (unions [
      (fileFilter (file: any file.hasExt ["nix" "sh"]) ../.)
      ../nix
      ../docs
      ../LICENSE
      ../README.md
      ../flake.lock
    ]);
  };

  propagatedBuildInputs = attrValues {
    inherit (kdePackages) qtmultimedia qtsvg qtvirtualkeyboard;
  };

  dontWrapQtApps = true;

  installPhase = let
    basePath = "$out/share/sddm/themes/${final.pname}";
    overrides' = toINI {} theme-overrides;
    overrides = builtins.replaceStrings ["="] [" = "] overrides';

    # no, using baseNameOf on derivations don't do the right thing :/
    # so we have have this to not break things
    copyBg = bg: let
      name =
        if lib.isDerivation bg
        then bg.name
        else builtins.baseNameOf bg;
    in "cp ${bg} ${basePath}/backgrounds/${name}";
  in ''
    mkdir -p ${basePath}
    cp -r $src/* ${basePath}

    substituteInPlace ${basePath}/metadata.desktop \
      --replace-warn configs/default.conf configs/${theme}.conf

    chmod +w ${basePath}/configs/${theme}.conf
    echo '${overrides}' >> ${basePath}/configs/${theme}.conf

    chmod -R +w ${basePath}/backgrounds
    ${concatStringsSep "\n" (map copyBg extraBackgrounds)}
  '';

  passthru.test = callPackage ./test-package.nix {silent = final.finalPackage;};

  meta = {
    homepage = "https://github.com/uiriansan/SilentSDDM";
    description = "A very customizable SDDM theme that actually looks good";
    maintainers = [lib.maintainers.rexies];
    license = [lib.licenses.gpl3];
  };
})
