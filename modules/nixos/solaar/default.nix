{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.solaar;
in
{
  options.programs.solaar = {
    enable = mkEnableOption ''
      Solaar, the open source driver for Logitech devices.
    '';

    package = mkOption {
      type = types.package;
      default = solaar-flake;
      defaultText = "pkgs.solaar-flake";
      description = ''
        Package witch is used for Solaar
      '';
    };
  };


  config = mkIf cfg.enable {
    hardware.logitech.wireless.enable = true;
    hardware.logitech.wireless.enableGraphical = mkForce false;
    environment.systemPackages = [ pkgs.internal.solaar ];
  };
}
