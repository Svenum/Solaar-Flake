# Solaar-Flake
This Repo is a Flake of [Solaar](https://github.com/pwr-Solaar/Solaar) for NixOS

# How to use?

Import
```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    solaar = {
      url = "https://github.com/Svenum/Solaar-Flake/latest; # For latest stable version
      #url = "https://github.com/Svenum/Solaar-Flake/release-1.1.10; # uncomment line for version 1.1.11rc1
      #url = "https://github.com/Svenum/Solaar-Flake/main; # Uncomment line for latest unstable version
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
