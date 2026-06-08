{
  description = "Solaar is an Open Source Logitech Driver for Linux";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus?rev=a00f6f51907b5c74d2fde086b10b19d446d15717";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      utils,
      ...
    }:
    let
      inherit (utils.lib) exportOverlays exportPackages exportModules;
    in
    utils.lib.mkFlake {
      inherit self inputs;

      sharedOverlays = [
        (import ./packages)
      ];

      nixosModules = exportModules [
        ./modules/nixos/solaar
        ./modules/nixos/solaar/default.nix
      ];

      overlays = exportOverlays {
        inherit (self) pkgs inputs;
      };

      outputsBuilder = channels: {
        packages = exportPackages self.overlays channels;
      };
    };
}
