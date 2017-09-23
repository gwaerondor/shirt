OUTDIR=ebin/

compile:
	mkdir -p $(OUTDIR)
	erlc -o $(OUTDIR) src/ericsson.erl
	erlc -o $(OUTDIR) src/enc.erl

eunit:
	$(MAKE) compile
	erlc -o $(OUTDIR) test/enc_tests.erl
	erl -noshell -pa ebin/ -eval 'eunit:test(enc_tests, [verbose]).' -s init stop
