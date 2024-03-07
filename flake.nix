{
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = {
    fenix,
    flake-utils,
    nixpkgs,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      packages.default = with pkgs;
        buildNpmPackage {
          pname = "test";
          version = "1.0.0";

          src = ./.;

          npmDepsHash = "sha256-knY2ViT5hZ+XRP5eSlT1b14w7BsfOW333U5ZiM+64m8=";

          npmPackFlags = ["--ignore-scripts"];

          NODE_OPTIONS = "--openssl-legacy-provider";
        };
    });
}
