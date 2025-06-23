{
  description = "A very customizable SDDM theme that actually looks good";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    # unsure if we need to include darwin but no harm in doing so
    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forAllSystems = f:
      nixpkgs.lib.genAttrs systems (
        system:
          f (import nixpkgs {inherit system;})
      );
  in {
    packages = forAllSystems (pkgs: rec {
      default = pkgs.callPackage ./default.nix {
        # accurate versioning based on git rev for non tagged releases
        gitRev = self.rev or self.dirtyRev or null;
      };

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
