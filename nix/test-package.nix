{
  lib,
  stdenvNoCC,
  makeWrapper,
  kdePackages,
  silent,
  # override the below to false if not on wayland
  withWayland ? true,
  withLayerShellQt ? true,
}:
stdenvNoCC.mkDerivation (final: {
  name = "test-sddm-silent";
  dontUnpack = true;

  sddm-wrapped = kdePackages.sddm.override {
    extraPackages =
      silent.propagatedBuildInputs
      ++ lib.optionals withWayland [kdePackages.qtwayland]
      ++ lib.optionals withLayerShellQt [kdePackages.layer-shell-qt];
  };

  nativeBuildInputs = [makeWrapper];
  installPhase = ''
    makeWrapper ${final.sddm-wrapped}/bin/sddm-greeter-qt6 $out/bin/test-sddm-silent \
      --suffix QML2_IMPORT_PATH ':' ${silent}/share/sddm/themes/silent/components \
      --set QT_IM_MODULE qtvirtualkeyboard \
      --add-flags '--test-mode --theme ${silent}/share/sddm/themes/silent'
  '';
})
