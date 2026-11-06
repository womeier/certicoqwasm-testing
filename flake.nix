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

        # Both running and AOT-compiling the modules go through the Python
        # bindings (Module.serialize / Module.deserialize_file), so the wasmtime
        # CLI is no longer needed -- which also retires the version-matching
        # dance the two used to require.
        python3 = pkgs.python3.withPackages (ps: [
          ps.wasmtime
          ps.click
          ps.tqdm
        ]);

        wasm-benchmarks = pkgs.stdenv.mkDerivation {
          pname = "certirocq-wasm-benchmarks";
          inherit (certirocq) version src;

          nativeBuildInputs = [
            rocq-core
            certirocq
          ];

          dontConfigure = true;
          enableParallelBuilding = true;

          buildPhase = ''
            runHook preBuild

            # upstream's Makefiles call coqc/coq_makefile, which Rocq 9.1 no longer ships
            (cd benchmarks/lib && rocq makefile -f _CoqProject -o Makefile && make -j $NIX_BUILD_CORES)

            # some benchmarks (e.g. vs_hard) need a lot of stack to compile
            ulimit -s unlimited || true
            (cd benchmarks/wasm && rocq c -R .. CertiRocq.Benchmarks tests.v)

            runHook postBuild
          '';

          installPhase = ''
            runHook preInstall

            mkdir -p $out
            cp benchmarks/wasm/CertiRocq.Benchmarks.wasm.tests.*.wasm $out/
            test "$(ls $out | wc -l)" = "$(grep -c . benchmarks/wasm/TESTS)"

            runHook postInstall
          '';
        };

      in
      {
        packages.default = certirocq;
        packages.wasm-benchmarks = wasm-benchmarks;

        devShells.default = pkgs.mkShell {
          name = "shell";
          packages = [
            wasmtime
            certirocq
            rocq-core
            pkgs.wasm-tools
            pkgs.binaryen
            pkgs.nodejs_24
            python3
            rocqPackages.vsrocq-language-server
          ];
          shellHook = ''
            echo "Entered nix shell."
          '';
        };
      }
    );
}
