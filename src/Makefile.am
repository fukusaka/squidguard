bin_PROGRAMS = squidGuard

squidGuard_SOURCES = \
sg.h sgEx.h main.c sgLog.c sgDb.c sgDiv.c sgFree.c sgParser.y sgLex.l \
wwwsys.h HTEscape.h HTParse.c

BUILT_SOURCES = sgParser.h
AM_YFLAGS = -d


CHECKSYNTAX = $(CC) $(CFLAGS) $(CPPFLAGS) -Wall -Wextra -pedantic -fsyntax-only

check-syntax:
	$(CHECKSYNTAX) $(CHK_SOURCES)
