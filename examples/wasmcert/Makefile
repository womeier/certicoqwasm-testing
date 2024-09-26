all: Makefile.coq
	make -f Makefile.coq all

clean: Makefile.coq
	make -f Makefile.coq cleanall
	@rm -f Makefile.coq Makefile.coq.conf

install: Makefile.coq
	make -f Makefile.coq install

Makefile.coq: _CoqProject
	coq_makefile -f _CoqProject -o Makefile.coq

.PHONY: all clean
