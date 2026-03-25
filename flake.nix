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

        coqPackages = pkgs.coqPackages_9_1;
        coq = coqPackages.coq;
        certirocq = coqPackages.CertiRocq;

      in
      {
        packages.default = certirocq;

        devShells.default = pkgs.mkShell {
          name = "shell";
          packages = [
            certirocq
            coq
            pkgs.wasm-tools
            pkgs.binaryen
            pkgs.nodejs_24
            pkgs.wasmtime
            coqPackages.vscoq-language-server
          ];
          shellHook = ''
            echo "Entered nix shell."
          '';
        };
      }
    );
}
