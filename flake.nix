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
    nixosModules.sddm-cache-clear = { config, lib, pkgs, ... }:
    let
      cfg = config.sddm.cache;
    in
    {
      options.sddm.cache = {
        clearOnBoot = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = ''
            Whether to clear the SDDM cache on every boot.
            This is useful for themes that sometimes fail to load due to stale cache.
          '';
        };
      };

      config = lib.mkIf cfg.clearOnBoot {
        services.displayManager.preStart = ''
          ${pkgs.util-linux}/bin/logger -t sddm-cache-clear "Clearing SDDM cache..."
          rm -rf /var/lib/sddm/.cache
          ${pkgs.util-linux}/bin/logger -t sddm-cache-clear "SDDM cache cleared."
        '';
      };
    };
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
