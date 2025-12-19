{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf mkEnableOption pipe mkOption literalExpression;
  inherit (lib.types) enum attrsWith path attrs package;
  inherit (lib.strings) removeSuffix;
  inherit (lib.attrsets) attrValues;
  inherit (lib.filesystem) listFilesRecursive;

  configs = pipe (listFilesRecursive ../configs) [
    (map builtins.baseNameOf)
    (map (removeSuffix ".conf"))
  ];

  # TODO pass gitRev somehow? (maybe like quickshell?)
  silent = pkgs.callPackage ./package.nix {};
  cfg = config.programs.silentSDDM;
  silent' = cfg.package'; # silent with configuration applied
in {
  options.programs.silentSDDM = {
    enable = mkEnableOption "silentSDDM theme";

    package = mkOption {
      type = package;
      default = silent;
      description = "silentSDDM package to use";
    };

    theme = mkOption {
      type = enum configs;
      default = "rei";
      example = "ken";
      description = "the builtin theme to use";
    };

    backgrounds = mkOption {
      type = attrsWith {
        placeholder = "image";
        elemType = path;
      };
      default = {};
      example = literalExpression ''
        {
          reze = pkgs.fetchurl {
            name = "hana.jpg";
            url = "https://cdn.donmai.us/original/b8/a2/__reze_chainsaw_man_drawn_by_busuttt__b8a2fd187890a40b9d293dacbd6da2b0.jpg";
            hash = "sha256-xF/1Rx/x4BLaj0mA8rWa67cq/+K6NdkOcCAB7R11+M0=";
          };
          kokomi = "/images/kokomi/kokomi96024.png";
          boring = "''${pkgs.gnome-backgrounds}/share/backgrounds/gnome/symbolic-d.png";
        }
      '';
      description = "attrset containing drvs or absolute path to wallpapers";
    };

    settings = mkOption {
      type = attrs;
      default = {};
      example = literalExpression ''
        {
            "LoginScreen.LoginArea.Avatar" = {
              shape = "circle";
              active-border-color = "#ffcfce";
            };
            "LoginScreen" = {
              background = "hana.jpg";
            };
            "LockScreen" = {
              background = "kokomi96024.png";
            };
        }
      '';
      description = ''
        attrset containing silent sddm configuration
        these settings overwrite the defaults set by the `theme`
        see https://github.com/uiriansan/SilentSDDM/wiki/Options
      '';
    };

    package' = mkOption {
      internal = true;
      readOnly = true;
      visible = false;
      default = cfg.package.override {
        inherit (cfg) theme;
        extraBackgrounds = attrValues cfg.backgrounds;
        theme-overrides = cfg.settings;
      };
      description = "silentSDDM package with configuration applied. INTERNAL USE ONLY";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [silent' silent'.test];
    qt.enable = true;
    systemd.services.display-manager.enable = true;
    services.displayManager.sddm = {
      wayland.enable = ! config.services.xserver.enable;
      enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "silent";
      # requires reboot to take effect
      extraPackages = silent'.propagatedBuildInputs;
      # required for styling the virtual keyboard
      settings = {
        General = {
          GreeterEnvironment = "QML2_IMPORT_PATH=${silent'}/share/sddm/themes/silent/components/,QT_IM_MODULE=qtvirtualkeyboard";
          InputMethod = "qtvirtualkeyboard";
        };
      };
    };
  };
}
