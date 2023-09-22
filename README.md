# Solaar-Flake
This Repo is a Flake of [Solaar](https://github.com/pwr-Solaar/Solaar) for NixOS

# How to use?

Import
```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    solaar = {
      #url = "https://github.com/Svenum/Solaar-Flake/release-1.1.9; # For latest stable version
      #url = "https://github.com/Svenum/Solaar-Flake/release-1.1.10rc; # For latest beta version
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {nixpkgs, solaar}: {
    nixosConfigurations.foo = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({pkgs, ...}: {
          environment.systemPackages = [solaar.packages.${pkgs.system}.solaar];
        })
      ];
    };
  }
}
```
