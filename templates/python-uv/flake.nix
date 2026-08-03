{
  description = "Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };

        # Backend-specific C libraries.
        backendLibs = [
          pkgs.stdenv.cc.cc.lib
          pkgs.zlib
        ];
      in
      {
        devShells = {
          default = pkgs.mkShell {
            buildInputs = backendLibs ++ [
				pkgs.uv
                pkgs.python313
                pkgs.ruff
              ];

            LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath backendLibs;

            shellHook = ''
              export UV_PYTHON=${pkgs.python313}/bin/python3.13
            '';
          };
        };

        # Formatter to use with the `nix fmt` command.
        formatter = pkgs.nixfmt-tree;
      }
    );
}
