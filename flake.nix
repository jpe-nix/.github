{
  description = "jpe-nix community defaults development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-26.05-darwin";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nix-devenv = {
      url = "github:dryvist/nix-devenv?ref=v0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, nix-devenv, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "x86_64-linux"
        "aarch64-linux"
      ];
      imports = [ nix-devenv.flakeModules.markdown ];
      perSystem =
        { pkgs, config, ... }:
        {
          devShells.default = pkgs.mkShell {
            inputsFrom = [ config.pre-commit.devShell ];
          };
        };
    };
}
