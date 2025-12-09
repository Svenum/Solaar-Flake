{
  description = "Solaar is an Open Source Logitech Driver for Linux";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus?rev=afcb15b845e74ac5e998358709b2b5fe42a948d1";
  };

  outputs = inputs@{ self, nixpkgs, utils, ... }:
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
