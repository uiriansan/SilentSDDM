{
  lib,
  stdenvNoCC,
  kdePackages,
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

  theme-package = stdenvNoCC.mkDerivation (final: {
    pname = "silent";
    version = "${builtins.substring 0 8 gitRev}";

    src = cleanSource ./.;

    dontWrapQtApps = true;

    propagatedBuildInputs = with kdePackages; [
      qtmultimedia
      qtsvg
      qtvirtualkeyboard
    ];

    installPhase = let
      basePath = "$out/share/sddm/themes/${final.pname}";
      baseConfigFile = "${final.src}/configs/${theme}.conf";
      overrides = lib.generators.toINI {} theme-overrides;
      finalConfig = (builtins.readFile baseConfigFile) + "\n" + overrides;
      finalConfigFile = writeText "${theme}.conf" finalConfig;
    in ''
      mkdir -p ${basePath}
      cp -r $src/* ${basePath}

      substituteInPlace ${basePath}/metadata.desktop \
        --replace-warn configs/default.conf configs/${theme}.conf

      chmod +w ${basePath}/configs/${theme}.conf
      cp ${finalConfigFile} ${basePath}/configs/${theme}.conf

      chmod -R +w ${basePath}/backgrounds
      ${builtins.concatStringsSep "\n" (builtins.map (bg: "cp ${bg} ${basePath}/backgrounds/${bg.name}") extraBackgrounds)}
    '';

    meta.licenses = licenses.gpl3;
    passthru.test = test;
  });

  sddm-wrapped = kdePackages.sddm.override {
    extraPackages = theme-package.propagatedBuildInputs;
    inherit withLayerShellQt withWayland;
  };

  test = symlinkJoin {
    name = "test-sddm-silent";
    paths = [sddm-wrapped];
    nativeBuildInputs = [makeWrapper];
    postBuild = ''
      makeWrapper $out/bin/sddm-greeter-qt6 $out/bin/test-sddm-silent \
        --suffix QML2_IMPORT_PATH ':' ${theme-package}/share/sddm/themes/${theme-package.pname}/components \
        --set QT_IM_MODULE qtvirtualkeyboard \
        --add-flags '--test-mode --theme ${theme-package}/share/sddm/themes/${theme-package.pname}'
    '';
  };
in
  theme-package
