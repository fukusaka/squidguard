EXTRA_DIST = \
requests \
blacklist/domains blacklist/expressions blacklist/urls \
test1.expected test2.expected

CLEANFILES = \
test1.output test2.output squidGuard.log

check: test1 test2 benchmark

test1 test2::	test1.conf test2.conf ../src/squidGuard requests
	@echo $@..
	@$(RM) squidGuard.log
	@echo Database size:
	@if [ $@ = test1 ];\
	then\
	    wc -l $(srcdir)/blacklist/domains $(srcdir)/blacklist/urls;\
	else\
	    wc -l $(srcdir)/blacklist/domains $(srcdir)/blacklist/urls $(srcdir)/blacklist/expressions;\
	fi
	@wc -l < $(srcdir)/requests | $(AWK) '{printf "Running $@ with %d requests..",$$1}'
	@-cat $(srcdir)/requests | ../src/squidGuard -c $@.conf | grep -v Processing |grep -v done >$@.output; exit 0
	@echo .Done
	@echo $(ECHO_N) "Checking number of output lines..$(ECHO_C)"
	@test `wc -l < $(srcdir)/requests` -eq `wc -l < $@.output`
	@echo .OK
	@echo $(ECHO_N) "Checking the output against the expected..$(ECHO_C)"
	@cmp -s $@.output $(srcdir)/$@.expected
	@echo .OK
	@lines=`wc -l < $(srcdir)/requests`;\
	$(AWK) -F'[()]' '/ squidGuard.+started \([0-9]+\.[0-9]+\)$$/ {start=$$(NF-1)};\
		       / squidGuard ready for ''requests \([0-9]+\.[0-9]+\)$$/ {ready=$$(NF-1)};\
		       / squidGuard stopped \([0-9]+\.[0-9]+\)$$/ {stop=$$(NF-1)};\
		       END {printf "squidGuard initialization took %.3f seconds\n",ready-start;\
			    printf "squidGuard handled %d ''requests in %.3f seconds\n",\
			    '"$$lines"',stop-ready}' \
		squidGuard.log
	@echo ""

benchmark::	test1.conf ../src/squidGuard requests
	@echo $@..
	@$(RM) squidGuard.log
	@echo Database size:
	@wc -l $(srcdir)/blacklist/domains $(srcdir)/blacklist/urls
	@wc -l < $(srcdir)/requests | $(AWK) '{printf "Running $@ test with %d requests..",$$1*100}'
	@-i=100; while [ $$i -gt 0 ]; do cat $(srcdir)/requests; i=`expr $$i - 1`;done \
	| ../src/squidGuard -c test1.conf>/dev/null; exit 0
	@echo .Done
	@lines=`wc -l < $(srcdir)/requests`;\
	$(AWK) -F'[()]' '/ squidGuard.+started \([0-9]+\.[0-9]+\)$$/ {start=$$(NF-1)};\
		       / squidGuard ready for ''requests \([0-9]+\.[0-9]+\)$$/ {ready=$$(NF-1)};\
		       / squidGuard stopped \([0-9]+\.[0-9]+\)$$/ {stop=$$(NF-1)};\
		       END {printf "squidGuard initialization took %.3f seconds\n",ready-start;\
			    printf "squidGuard handled %d ''requests in %.3f seconds\n",\
			    '"$$lines"'*100,stop-ready}' \
		squidGuard.log
