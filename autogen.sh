#!/bin/sh

: ${ACLOCAL=aclocal}
: ${AUTOHEADER=autoheader}
: ${AUTOMAKE=automake}
: ${AUTOCONF=autoconf}

# So instead:
$ACLOCAL -I m4
$AUTOCONF
$AUTOHEADER
[ ! -d build-aux ] && mkdir build-aux
$AUTOMAKE --add-missing --copy
