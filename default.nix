{
  pkgs,
  lib,
  stdenvNoCC,
}: let
  fs = lib.fileset;
  exclude = fs.unions [./default.nix ./flake.nix ./flake.lock];
in
  stdenvNoCC.mkDerivation {
    name = "SilentSDDM";
    version = "0.9.1";

    src = fs.toSource {
      root = ./.;
      fileset = fs.difference ./. exclude;
    };

    dontWrapQtApps = true;

    propagatedBuildInputs = with pkgs.kdePackages; [
      qtmultimedia
      qtsvg
      qtvirtualkeyboard
    ];

    installPhase = let
      basePath = "$out/share/sddm/themes/silent";
    in ''
      mkdir -p ${basePath}
      cp -r $src/* ${basePath}
    '';
  }
