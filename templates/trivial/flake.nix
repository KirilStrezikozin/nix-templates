{
  description = "Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = false;
          };
        };

        inputsForScripts = [];

        inputsTooling = [
          pkgs.pre-commit
        ];
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
          ]
          ++ inputsForScripts
          ++ inputsTooling;
        };

        formatter = pkgs.nixpkgs-fmt;
      }
    );
}
