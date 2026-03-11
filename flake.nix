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

        # TODO: use upstream once available in nixpkgs
        certirocq = coqPackages.mkCoqDerivation {
          pname = "certirocq";
          version = "aff6fdf";
          owner = "certirocq";
          repo = "certirocq";
          src = pkgs.fetchFromGitHub {
            owner = "certirocq";
            repo = "certirocq";
            rev = "aff6fdf0d288310286e5f7d17f0217b3ce0b0413";
            sha256 = "sha256-eQDOhH/QcQnkP90gAs9KvF/6u0Gq7AadJ5MyNz5fEMY=";
          };

          mlPlugin = true;

          propagatedBuildInputs = with coqPackages; [
            wasmcert
            coqprime
            compcert
            ExtLib
            metarocq
          ];

          patchPhase = ''
            patchShebangs ./configure.sh
            patchShebangs ./clean_extraction.sh
            patchShebangs ./make_plugin.sh
          '';

          configurePhase = ''
            ./configure.sh local
          '';

          buildPhase = ''
            runHook preBuild

            make
            make plugin
            make cplugin

            runHook postBuild
          '';

          installPhase = ''
            runHook preInstall

            OUTDIR=$out/lib/coq/${coq.coq-version}/user-contrib

            DST=$OUTDIR/CertiRocq/Plugin/runtime make -C runtime install
            COQLIBINSTALL=$OUTDIR make -C theories install
            COQLIBINSTALL=$OUTDIR make -C libraries install
            COQLIBINSTALL=$OUTDIR COQPLUGININSTALL=$OCAMLFIND_DESTDIR make -C plugin install
            COQLIBINSTALL=$OUTDIR COQPLUGININSTALL=$OCAMLFIND_DESTDIR make -C cplugin install

            runHook postInstall
          '';

          meta = {
            description = "CertiRocq";
            maintainers = [ lib.maintainers.womeier ];
            license = lib.licenses.mit;
          };
        };
      in
      {
        packages.default = certirocq;

        devShells.default = pkgs.mkShell {
          name = "shell";
          packages = [
            certirocq
            coq
            pkgs.wasm-tools
            pkgs.nodejs_24
            pkgs.wasmtime
          ];
          shellHook = ''
            echo "Entered nix shell."
          '';
        };
      }
    );
}
