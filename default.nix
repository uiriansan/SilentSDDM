{
  lib,
  stdenvNoCC,
  kdePackages,
  writeText,
  gitRev ? "unknown",
  theme ? "default",
  theme-overrides ? {},
  extraBackgrounds ? [],
}: let
  inherit (lib) cleanSource licenses;
in
  stdenvNoCC.mkDerivation (final: {
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
  })
