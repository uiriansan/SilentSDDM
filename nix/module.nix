{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) map pipe flatten flip elem assertMsg;
  inherit (lib) mkIf mkEnableOption mkOption literalExpression;
  inherit (lib.types) enum attrsWith path attrs package;
  inherit (lib.strings) removeSuffix;
  inherit (lib.attrsets) attrNames attrValues mapAttrs filterAttrs;
  inherit (lib.filesystem) listFilesRecursive;

  users = attrNames config.users.users;
  configs = pipe (listFilesRecursive ../configs) [
    (map builtins.baseNameOf)
    (map (removeSuffix ".conf"))
  ];

  # TODO pass gitRev somehow? (maybe like quickshell?)
  # this is done this way to be independent of the flake
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

    profileIcons = mkOption {
      type = attrsWith {
        placeholder = "image";
        elemType = path;
      };
      default = {};
      example = literalExpression ''
        {
          # <username> = <path / drv>
          kokomi = "/images/kokomi/kokomi96024.png";
          rexies = fetchurl {
            url = "https://upload-os-bbs.hoyolab.com/upload/2021/09/22/84300862/129d3f6ded12d26d20ea4e4fa3e098d7_9177972037247649366.jpg";
            hash = ""
          };
        }
      '';
      description = "attrset containing <username>, <profile-img> map";
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

    profileIcons' = mkOption {
      internal = true;
      readOnly = true;
      visible = false;
      default = cfg.profileIcons;
      apply = flip pipe [
        (filterAttrs (user: _: assertMsg (elem user users) "programs.silentSDDM.profileIcons: '${user}' is not a valid user"))
        (mapAttrs (user: icon: [
          "f+ /var/lib/AccountsService/users/${user}  0600 root root -  [User]\\nIcon=/var/lib/AccountsService/icons/${user}\\n"
          "L+ /var/lib/AccountsService/icons/${user}  -    -    -    -  ${icon}"
        ]))
        attrValues
        flatten
      ];
      description = "converts profileIcons attrset into systemd tmpfiles expressions";
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

    # setup profile pictures
    systemd.tmpfiles.rules = mkIf (cfg.profileIcons != {}) cfg.profileIcons';
  };
}
