{ config, lib, ... }:

with lib;

let
  cfg = config.programs.solaar;
  solaar-flake = pkgs.callPackage ./package.nix;
in
{
  options.programs.solaar = {
    enable = mkEnableOption ''
      Solaar, the open source driver for Logitech devices.
    '';

    package = mkOption {
      type = types.Package;
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
    environment.systemPackages = [ cfg.package ];
  };
}
