{
  description = "CertiCoq-Wasm testing environment";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # The CertiRocq revision under test. A flake input rather than a
    # fetchFromGitHub, so selecting a revision needs no source hash:
    #   nix build .#wasm-benchmarks \
    #     --override-input certirocq-src github:CertiRocq/certirocq/<sha>
    # The lock records rev + narHash, and cross-owner overrides work, so
    # upstream-vs-fork comparisons need no extra machinery.
    certirocq-src = {
      url = "github:CertiRocq/certirocq/943b52ae654708130f241ccf8a50ecb95a7956e2";
      flake = false;
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      certirocq-src,
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

        # the CertiRocq revision under test, see the certirocq-src input
        certirocqRev = certirocq-src.rev;

        # MetaRocq snapshot, which has to move with the certirocq-src revision --
        # upstream tracks the *branch* `9.1` (.nix/config.nix, build.yml), so there is
        # no pin to copy and each era needs its own. Two boundaries found so far:
        #
        #   b700cc6a (2026-06-09, "Complete the MetaRocq pipeline") starts importing
        #     EImplementLazyForce, which the 1.5.1 release nixpkgs selects for Rocq 9.1
        #     does not have.  Revisions before it, including the 0.9.1 release, build
        #     against plain 1.5.1-9.1.  (ab814928 only pinned the snapshot in CI four
        #     months later; it is not the boundary.)
        #   1afbc3a4 (2026-10-31, "Update to latest MetaRocq 9.1 branch") needs
        #     165c28dd or later: plugins/plugin/plugin-manifest now lists the universe
        #     loop-checking modules (UnivLoopChecking, HornClauses, PartialLoopChecking,
        #     ...) that 8a431a84 introduced, and plugins/manifests/generate.py fails the
        #     build on a manifest that does not match the extracted ML.  This is late in
        #     the build, after all of theories/ compiles, so it looks like a packaging
        #     error rather than a version mismatch.
        #
        # c8cd4605 is the snapshot for the era in between (it was the branch tip for the
        # whole 2026-08-10..2026-10-30 gap).  51b14e4b is the current branch tip.
        metarocqVersion = "1.5.1-9.1-51b14e4b";
        metarocqRev = "51b14e4bb5f4580f00f60208ff8dbf31f3ad6f56";
        metarocqHash = "sha256-sQ4q/ndbWiiXg4xhT3mNfPz1qjOi3hTu5wfLm27lIjQ=";

        rocqPackages = pkgs.rocqPackages_9_1.overrideScope (
          self: super: {
            # all metarocq-* attributes are derived from this one, so overriding the
            # release table here covers the erasure and safechecker plugins too
            metarocq = super.metarocq.override (args: {
              mkCoqDerivation =
                drv:
                (args.mkCoqDerivation drv).override {
                  defaultVersion = metarocqVersion;
                  release.${metarocqVersion} = {
                    rev = metarocqRev;
                    hash = metarocqHash;
                  };
                };
            });

            # nixpkgs pairs Rocq 9.1 with wasmcert 2.2.0, which is what the CertiRocq
            # 0.9.1 release needs. Revisions after CertiRocq PR #166 (478e9a82) need
            # 2.2.1, e.g. for write_bytes_gen_preserve_length. Move this along with the
            # CertiRocq pin below.
            wasmcert = super.wasmcert.override { version = "2.2.1"; };

            # the revision under test comes from the certirocq-src input above
            CertiRocq = (super.CertiRocq.override { version = "0.9.1+9.1"; }).overrideAttrs (old: {
              # plugins/manifests/generate.py, called from the Makefile since the
              # 0.9.1 release, needs a python3 in the build environment
              nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.python3 ];

              # nixpkgs works around two things upstream fixed in PR #162 (merged
              # before 943b52ae) and does so with --replace-fail, so its patch phase
              # hard-fails on every revision that already carries the fix. Guard each
              # workaround instead, so old and new revisions both patch cleanly.
              # Note the aST pattern is a prefix of its own replacement, so the guard
              # has to match the whole line -- --replace-fail would happily corrupt an
              # already-fixed clean_extraction.sh.
              postPatch = ''
                patchShebangs ./configure.sh
                patchShebangs ./clean_extraction.sh
                patchShebangs ./make_plugin.sh

                if grep -q "gcc -I /opt/homebrew/include" runtime/Makefile; then
                  substituteInPlace runtime/Makefile \
                    --replace-fail "gcc -I /opt/homebrew/include" '$(CC)'
                fi

                if grep -qx "mv aST.ml AST.ml" clean_extraction.sh; then
                  substituteInPlace clean_extraction.sh \
                    --replace-fail "mv aST.ml AST.ml" "mv aST.ml AST.ml.tmp && mv AST.ml.tmp AST.ml" \
                    --replace-fail "mv aST.mli AST.mli" "mv aST.mli AST.mli.tmp && mv AST.mli.tmp AST.mli"
                fi
              '';

              # the 0.9.1 release keeps plugin/ and cplugin/ at the top level, main
              # moved them under plugins/
              installPhase =
                ''
                  PLUGINS=plugins
                  if [ ! -d plugins/plugin ]; then PLUGINS=.; fi
                ''
                + builtins.replaceStrings
                  [ "make -C plugin install" "make -C cplugin install" ]
                  [ "make -C $PLUGINS/plugin install" "make -C $PLUGINS/cplugin install" ]
                  old.installPhase;

              src = certirocq-src;
            });
          }
        );
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
          version = builtins.substring 0 8 certirocqRev;
          inherit (certirocq) src;

          nativeBuildInputs = [
            rocq-core
            certirocq
          ];

          dontConfigure = true;
          enableParallelBuilding = true;

          # Only revisions after upstream renamed benchmarks/ -> tests/ (a3f40fd7)
          # are supported. Earlier ones, including the 0.9.1 release, compile under
          # the logical path CertiRocq.Benchmarks and so emit
          # CertiRocq.Benchmarks.wasm.tests.*.wasm, which none of the evaluation
          # scripts read -- they all hardcode CertiRocq.Tests, as do the staged
          # evaluation/binaries/* folders.
          buildPhase = ''
            runHook preBuild

            if [ ! -d tests ]; then
              echo "No tests/ directory: this revision predates the" >&2
              echo "benchmarks/ -> tests/ rename (a3f40fd7) and is not supported." >&2
              exit 1
            fi

            # upstream's Makefiles call coqc/coq_makefile, which Rocq 9.1 no longer ships
            (cd tests/lib && rocq makefile -f _CoqProject -o Makefile && make -j $NIX_BUILD_CORES)

            # some benchmarks (e.g. vs_hard) need a lot of stack to compile
            ulimit -s unlimited || true
            (cd tests/wasm && rocq c -R .. CertiRocq.Tests tests.v)

            runHook postBuild
          '';

          installPhase = ''
            runHook preInstall

            mkdir -p $out
            cp tests/wasm/CertiRocq.Tests.wasm.tests.*.wasm $out/
            test "$(ls $out/*.wasm | wc -l)" = "$(grep -c . tests/wasm/TESTS)"

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
            pkgs.wasmtime
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
