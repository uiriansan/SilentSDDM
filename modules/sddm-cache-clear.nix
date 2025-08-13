{ config, lib, pkgs, ... }:

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
}