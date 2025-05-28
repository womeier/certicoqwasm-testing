all: Makefile.coq
	@make -C lib
	@+$(MAKE) -f Makefile.coq all

# copies Wasm binary so it's used by local chromium demo
install: all
	wasm-opt --enable-tail-call -O2 ./Demo.sha256_webdemo.sha_fast.wasm -o ./Demo.sha256_webdemo.sha_fast_O2.wasm
	cp ./Demo.sha256_webdemo.sha_fast_O2.wasm ../files/certicoqwasm-demo/sha_fast.wasm


clean: Makefile.coq
	@+$(MAKE) -f Makefile.coq cleanall
	@rm -f Makefile.coq Makefile.coq.conf
	@make -C lib clean
	@rm -f *.wasm *.wat *.ir

Makefile.coq: _CoqProject
	$(COQBIN)coq_makefile -f _CoqProject -o Makefile.coq

force _CoqProject Makefile: ;

%: Makefile.coq force
	@+$(MAKE) -f Makefile.coq $@

.PHONY: all clean force install
