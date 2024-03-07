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

          npmDepsHash = "sha256-nxMcxEGQ+lxIgWfAgrgn654Vj9q694oSo9tc3s0qjV4=";

          npmPackFlags = ["--ignore-scripts"];

          NODE_OPTIONS = "--openssl-legacy-provider";
        };
    });
}
