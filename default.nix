{
  lib,
  stdenvNoCC,
  kdePackages,
  qt6,
  writeText,
  makeWrapper,
  symlinkJoin,
  gitRev ? "unknown",
  theme ? "default",
  theme-overrides ? {},
  extraBackgrounds ? [],
  # override the below to false if not on wayland (only matters for test script)
  withWayland ? true,
  withLayerShellQt ? true,
}: let
  inherit (lib) cleanSource licenses;
  inherit
    (lib)
    attrValues
    substring
    readFile
    concatStringsSep
    map
    ;
  inherit (lib.generators) toINI;
  inherit (stdenvNoCC) mkDerivation;

  propagatedBuildInputs = attrValues {
    inherit (kdePackages) qtmultimedia qtsvg qtvirtualkeyboard;
  };

  sddm-wrapped = kdePackages.sddm.override {
    extraPackages =
      propagatedBuildInputs
      ++ lib.optionals withWayland [qt6.qtwayland]
      ++ lib.optionals withLayerShellQt [kdePackages.layer-shell-qt];
  };
in
  mkDerivation (final: {
    inherit propagatedBuildInputs;

    pname = "silent";
    version = "${substring 0 8 gitRev}";
    src = cleanSource ./.;

    dontWrapQtApps = true;

    installPhase = let
      basePath = "$out/share/sddm/themes/${final.pname}";
      overrides' = toINI {} theme-overrides;
      overrides = builtins.replaceStrings ["="] [" = "] overrides';
    in ''
      mkdir -p ${basePath}
      cp -r $src/* ${basePath}

      substituteInPlace ${basePath}/metadata.desktop \
        --replace-warn configs/default.conf configs/${theme}.conf

      chmod +w ${basePath}/configs/${theme}.conf
      echo '${overrides}' >> ${basePath}/configs/${theme}.conf

      chmod -R +w ${basePath}/backgrounds
      ${concatStringsSep "\n" (map (bg: "cp ${bg} ${basePath}/backgrounds/${bg.name}") extraBackgrounds)}
    '';

    passthru.test = symlinkJoin {
      name = "test-sddm-silent";
      paths = [sddm-wrapped];
      nativeBuildInputs = [makeWrapper];
      postBuild = ''
        makeWrapper $out/bin/sddm-greeter-qt6 $out/bin/test-sddm-silent \
          --suffix QML2_IMPORT_PATH ':' ${final.finalPackage}/share/sddm/themes/${final.pname}/components \
          --set QT_IM_MODULE qtvirtualkeyboard \
          --add-flags '--test-mode --theme ${final.finalPackage}/share/sddm/themes/${final.pname}'
      '';
    };

    meta.licenses = licenses.gpl3;
  })
