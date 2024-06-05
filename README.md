# Solaar-Flake
This Repo is a Flake of [Solaar](https://github.com/pwr-Solaar/Solaar) for NixOS.

See also the [FlakeHub](https://flakehub.com/flake/Svenum/Solaar-Flake) release.

# How to use?

Import
```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz" # For latest stable version
      #url = "https://flakehub.com/f/Svenum/Solaar-Flake/1.1.13.tar.gz" # uncomment line for version 1.1.13
      #url = "github:Svenum/Solaar-Flake/main"; # Uncomment line for latest unstable version
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {nixpkgs, solaar}: {
    nixosConfigurations.foo = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
          solaar.nixosModules.default
          configuration.nix
      ];
    };
  }
}
```
Then enable it by putting:
```nix
...
    programs.solaar.enable = true;
...
```
in configuration.nix
