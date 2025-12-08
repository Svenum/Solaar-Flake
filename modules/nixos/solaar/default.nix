{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.solaar;
  solaar = pkgs.callPackage ../../../packages/solaar { };
in {
  options.services.solaar = {
    enable = mkEnableOption ''
      Solaar, the open source driver for Logitech devices.
    '';

    package = mkOption {
      type = types.package;
      default = solaar;
      defaultText = "solaar";
      description = ''
        Package witch is used for Solaar
      '';
    };

    window = mkOption {
      type = types.enum [ "show" "hide" "only" ];
      default = "hide";
      description = ''
        Start with window showing / hidden / only (no tray icon)
      '';
    };

    batteryIcons = mkOption {
      type = types.enum [ "regular" "symbolic" "solaar" ];
      default = "regular";
      description = ''
        Prefer regular battery / symbolic battery / solaar icons
      '';
    };

    extraArgs = mkOption {
      type = types.str;
      default = "";
      example = "--restart-on-wake-up";
      description = ''
        Extra arguments to pass to Solaar
      '';
    };
  };

  config = mkIf cfg.enable {
    hardware.logitech.wireless.enable = true;
    hardware.logitech.wireless.enableGraphical = mkForce false;
    environment.systemPackages = [ cfg.package ];

    systemd.user.services.solaar = {
      description = "Solaar, the open source driver for Logitech devices";
      wantedBy = [ "graphical-session.target" ];
      after = [ "dbus.service" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${cfg.package}/bin/solaar --window ${cfg.window} --battery-icons ${cfg.batteryIcons} ${cfg.extraArgs}";
        Restart = "on-failure";
        RestartSec = "5";
      };
    };
  };

	imports = [
		(lib.mkRenamedOptionModule [ "programs" "solaar" "enable" ] [ "services" "solaar" "enable" ])
	];
}
