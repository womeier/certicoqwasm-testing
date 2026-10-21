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

        # wasmtime CLI (used to AOT-compile the modules) and the Python bindings
        # need to have the same version.
        wasmtime = pkgs.wasmtime;
        wasmtime-py = pkgs.python3Packages.wasmtime.overridePythonAttrs (old: {
          version = wasmtime.version;
          src = old.src; # keep the wasmtime-py tag the hash belongs to
          postPatch = old.postPatch + ''
            echo "${wasmtime.version}" > VERSION
          '';
        });

        python3 = pkgs.python3.withPackages (ps: [
          wasmtime-py
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
            certirocq
            rocq-core
            pkgs.wasm-tools
            pkgs.binaryen
            pkgs.nodejs_24
            wasmtime
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
