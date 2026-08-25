{
  description = "CertiCoq-Wasm testing environment";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        lib = nixpkgs.lib;
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfreePredicate =
            pkg:
            builtins.elem (lib.getName pkg) [
              "compcert"
            ];
        };

        rocqPackages = pkgs.rocqPackages_9_1;
        rocq-core = rocqPackages.rocq-core;
        certirocq = rocqPackages.CertiRocq;

      in
      {
        packages.default = certirocq;

        devShells.default = pkgs.mkShell {
          name = "shell";
          packages = [
            certirocq
            rocq-core
            pkgs.wasm-tools
            pkgs.binaryen
            pkgs.nodejs_24
            pkgs.wasmtime
            rocqPackages.vsrocq-language-server
          ];
          shellHook = ''
            echo "Entered nix shell."
          '';
        };
      }
    );
}
