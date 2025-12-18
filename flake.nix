{
  description = "A very customizable SDDM theme that actually looks good";
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    inherit (nixpkgs) lib legacyPackages;
    systems = ["x86_64-linux" "aarch64-linux"];
    forAllSystems = fn: lib.genAttrs systems (system: fn legacyPackages.${system});
  in {
    packages = forAllSystems (pkgs: rec {
      # you may test these themes with `nix run .#default.test`
      # similiarly `nix run .#example.test` will work too
      default = pkgs.callPackage ./default.nix {
        # accurate versioning based on git rev for non tagged releases
        gitRev = self.rev or self.dirtyRev or "unknown";
      };

      # here to not break the old test package
      test = default.test;

      # an exhaustive example illustrating how themes can be configured
      example = let
        zero-bg = pkgs.fetchurl {
          url = "https://www.desktophut.com/files/kV1sBGwNvy-Wallpaperghgh2Prob4.mp4";
          hash = "sha256-VkOAkmFrK9L00+CeYR7BKyij/R1b/WhWuYf0nWjsIkM=";
        };
      in
        default.override {
          # one of configs/<$theme>.conf
          theme = "rei";
          # aditional backgrounds
          extraBackgrounds = [zero-bg];
          # overrides config set by <$theme>.conf
          theme-overrides = {
            # Available options: https://github.com/uiriansan/SilentSDDM/wiki/Options
            "LoginScreen.LoginArea.Avatar" = {
              shape = "circle";
              active-border-color = "#ffcfce";
            };
            "LoginScreen" = {
              background = "${zero-bg.name}";
            };
            "LockScreen" = {
              background = "${zero-bg.name}";
            };
          };
        };
    });
  };
}
