<a href="https://nixos.wiki/wiki/Flakes" target="_blank"><img alt="Nix Flakes Ready" src="https://img.shields.io/static/v1?logo=nixos&logoColor=d8dee9&label=Nix%20Flakes&labelColor=5e81ac&message=Ready&color=d8dee9&style=for-the-badge"></a>

# Solaar-Flake
This Repo is a Flake of [Solaar](https://github.com/pwr-Solaar/Solaar) for NixOS.

See also the [FlakeHub](https://flakehub.com/flake/Svenum/Solaar-Flake) release.

# Version Mapping

|Flake version|Solaar version|
|-|-|
|[0.1.6](https://github.com/Svenum/Solaar-Flake/releases/tag/0.1.6)|[1.1.18](https://github.com/pwr-Solaar/Solaar/releases/tag/1.1.18)|
|[0.1.5](https://github.com/Svenum/Solaar-Flake/releases/tag/0.1.5)|[1.1.17](https://github.com/pwr-Solaar/Solaar/releases/tag/1.1.17)|
|[0.1.5-rc.1](https://github.com/Svenum/Solaar-Flake/releases/tag/0.1.5-rc.1)|[1.1.17rc3](https://github.com/pwr-Solaar/Solaar/releases/tag/1.1.17rc3)|
|[0.1.4](https://github.com/Svenum/Solaar-Flake/releases/tag/0.1.4)|[1.1.16](https://github.com/pwr-Solaar/Solaar/releases/tag/1.1.16)|
|[0.1.3](https://github.com/Svenum/Solaar-Flake/releases/tag/0.1.3)|[1.1.15](https://github.com/pwr-Solaar/Solaar/releases/tag/1.1.15)|
|[0.1.3-rc.1](https://github.com/Svenum/Solaar-Flake/releases/tag/0.1.3-rc.1)|[1.1.15rc2](https://github.com/pwr-Solaar/Solaar/releases/tag/1.1.15rc2)|
|[0.1.2](https://github.com/Svenum/Solaar-Flake/releases/tag/0.1.2)|[1.1.14](https://github.com/pwr-Solaar/Solaar/releases/tag/1.1.14)|
|[0.1.2-rc.1](https://github.com/Svenum/Solaar-Flake/releases/tag/0.1.2-rc.1)|[1.1.14rc4](https://github.com/pwr-Solaar/Solaar/releases/tag/1.1.14rc4)|
|[0.1.1](https://github.com/Svenum/Solaar-Flake/releases/tag/0.1.1)|[1.1.13](https://github.com/pwr-Solaar/Solaar/releases/tag/1.1.13)|

# How to use?

Import
```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz"; # For latest stable version
      #url = "https://flakehub.com/f/Svenum/Solaar-Flake/0.1.6.tar.gz"; # uncomment line for solaar version 1.1.18
      #url = "github:Svenum/Solaar-Flake/main"; # Uncomment line for latest unstable version
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {nixpkgs, solaar}: {
    nixosConfigurations.foo = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
          solaar.nixosModules.default
        ./configuration.nix
      ];
    };
  }
}
```
Then enable it by putting:
```nix
...
    services.solaar.enable = true;
...
```
in configuration.nix

## Configuration

The configuration is done in the `configuration.nix` file. The following options are available:

```nix
{
  services.solaar = {
    enable = true; # Enable the service
    package = pkgs.solaar; # The package to use
    window = "hide"; # Show the window on startup (show, *hide*, only [window only])
    batteryIcons = "regular"; # Which battery icons to use (*regular*, symbolic, solaar)
    extraArgs = ""; # Extra arguments to pass to solaar on startup
  };
}
```
