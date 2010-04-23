#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.61])
AC_INIT([squidguard],[1.4],[nonmail@nosite])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([1.10 foreign])
AC_CONFIG_SRCDIR([src/main.c])
AC_CONFIG_HEADER([src/config.h])

dnl
dnl Handle command line arguments
dnl

AC_ARG_WITH(sg_config,
	AS_HELP_STRING([--with-sg-config=FILE],[location of squidGuard config file]),
                sg_config=$withval)

AC_ARG_WITH(sg_logdir,
	AS_HELP_STRING([--with-sg-logdir=DIR],[location of squidGuard log file]),
                sg_logdir=$withval)

AC_ARG_WITH(sg_dbhome,
	AS_HELP_STRING([--with-sg-dbhome=DIR],[location of squidGuard db dirs]),
                sg_dbhome=$withval)

test -z "$sg_cfgdir" && sg_cfgdir=/usr/local/squidGuard
test -z "$sg_config" && sg_config=${sg_cfgdir}/squidGuard.conf
test -z "$sg_logdir" && sg_logdir=/usr/local/squidGuard/log
test -z "$sg_dbhome" && sg_dbhome=/usr/local/squidGuard/db

AC_DEFINE_UNQUOTED([DEFAULT_CONFIGFILE],["$sg_config"],[no description])
AC_DEFINE_UNQUOTED([DEFAULT_LOGDIR],["$sg_logdir"],[no description])
AC_DEFINE_UNQUOTED([DEFAULT_DBHOME],["$sg_dbhome"],[no description])

AC_ARG_WITH(nolog,
	AS_HELP_STRING([--with-nolog=ARG],[supress logging except for start and stop messages (default: ARG=no)]),
	[AC_DEFINE([SUPRESS_LOGGING],[1],[no description])])

AC_ARG_WITH(squiduser,
	AS_HELP_STRING([--with-squiduser=USER],[do set squid user to USER (default: squid)]),
	[squiduser=$withval])

# Checks for programs.
AC_PROG_AWK
AC_PROG_CC
AM_PROG_CC_STDC
AM_C_PROTOTYPES
AC_PROG_INSTALL
AC_PROG_MAKE_SET
AC_PROG_CPP
AC_PROG_LEX
AC_PROG_YACC
AC_PATH_PROG(PERL,perl,no,$PATH:/usr/bin:/usr/local/bin/:/local/bin:/local/perl/bin:/usr/local/perl/bin)
AC_PROG_PERL_VERSION(5)
if test $PERL = no; then
	echo
	echo "** No Perl found in the PATH. Perl is required"
	echo "   for blocked.cgi to work "
	echo
	exit 1
fi

# Checks for libraries.

# Checks for header files.
AC_HEADER_STDC
AC_CHECK_HEADERS([unistd.h])
AC_CHECK_HEADERS([regex.h],,[
	echo
	echo "** No regex.h found"
	echo "   The regexp library is required for squidGuard"
	echo "   to compile. Get it from http://www.gnu.org"
	echo
	exit 1
	])

# Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST
AC_C_VOLATILE
AC_TYPE_SIZE_T
AC_TYPE_INT8_T
AC_TYPE_INT16_T
AC_TYPE_INT32_T
AC_TYPE_UINT8_T
AC_TYPE_UINT16_T
AC_TYPE_UINT32_T
AC_TYPE_MODE_T
AC_STRUCT_TM
AC_HEADER_TIME

# Checks for library functions.
AC_FUNC_MALLOC
AC_FUNC_MKTIME
AC_FUNC_REALLOC
AC_TYPE_SIGNAL
AC_FUNC_STAT
AC_CHECK_FUNCS(regcomp, , AC_MSG_ERROR([No regcomp library function.]))
AC_CHECK_FUNCS(regerror, , AC_MSG_ERROR([No regerror library function.]))
AC_CHECK_FUNCS(regexec, , AC_MSG_ERROR([No regexec library function.]))
AC_CHECK_FUNCS(strdup, , AC_MSG_ERROR([No strdup library function.]))
AC_CHECK_FUNCS(strerror, , AC_MSG_ERROR([No strerror library function.]))
AC_CHECK_FUNCS(vsprintf, , AC_MSG_ERROR([No vsprintf library function.]))
AC_CHECK_FUNCS(sigaction)
AC_CHECK_FUNCS(signal)

dnl Check Berkley DB
AC_ARG_WITH([db],
	AS_HELP_STRING([--with-db=DIR],[location of the Berkley DB distribution]),
	[dbprefix=${withval}])
AC_ARG_WITH([db_lib],
	AS_HELP_STRING([--with-db-lib=DIR],[location of the Berkley DB library]),
	[db_lib="${withval}"])
AC_ARG_WITH([db_inc],
	AS_HELP_STRING([--with-db-inc=DIR],[location of the Berkley DB include files]),
	[db_inc="${withval}"])

test -z "$dbprefix" && dbprefix=/usr/local
test -z "$db_inc" && db_inc=$dbprefix/include
test -z "$db_lib" && db_lib=$dbprefix/lib

CFLAGS="$CFLAGS -I$db_inc"
LIBS="$LIBS -L$db_lib"

AC_CHECK_HEADER([db.h],,[
	echo
	echo "** No db.h found"
	echo "   The Berkley DB library is required for squidGuard"
	echo "   to compile. Get it from http://www.oracle.com"
	echo "   use --with-db=DIR or --with-db-inc=DIR to specify"
	echo "   its location. (default is $dbprefix)"
	echo
	exit 1
       ])

AX_BERKELEY_DB([4.2],[
	AC_DEFINE_UNQUOTED([DB_HEADER], ["$DB_HEADER"])
	LIBS="$LIBS $DB_LIBS"
],[
	echo
	echo "** The Berkley DB library version 4.2 or newer"
	echo "   is required. Get it from http://www.oracle.com"
	echo
	exit 1;
])

dnl Check ldap
AC_ARG_WITH(ldap,
	AS_HELP_STRING([--with-ldap],[use ldap (default: no ldap)]))

if test "$with_ldap" = "yes" -o "$with_ldap" = "true"; then
	echo "checking for ldap support... yes"
	AC_CHECK_LIB(ldap, ldap_init,
	[
		with_ldap=yes
		LIBS="$LIBS -lldap"
		AC_DEFINE(HAVE_LIBLDAP,[],[ldap support])
	],[
		AC_MSG_WARN([Cannot find LDAP libraries. LDAP support disabled])
		with_ldap=no
	])
else
	echo "checking for ldap support... no"
	with_ldap=no
fi

dnl Check mysql
AC_ARG_WITH(mysql,
	AS_HELP_STRING([--with-mysql],[support for mysql (default: no mysql)]),
	[ with_mysql="$withval" ],
	[ with_mysql=no ])

MYSQL_CFLAGS=""
MYSQL_LIBS=""

if test "$with_mysql" = "no"; then
	echo "checking for mysql support... no"
else
	AC_PATH_PROG([MYSQL_CONFIG],[mysql_config],[no])

	AC_MSG_CHECKING([for MySQL libraries])
	if test "$MYSQL_CONFIG" != "no"; then

		MYSQL_CFLAGS="`$MYSQL_CONFIG --cflags`"
		MYSQL_LIBS="`$MYSQL_CONFIG --libs`"

		AC_DEFINE([HAVE_MYSQL],[1],
        		[Define to 1 if MySQL libraries are available])

		AC_MSG_RESULT([yes])
	else
		AC_MSG_RESULT([no])
	fi

	CFLAGS="$CFLAGS $MYSQL_CFLAGS"
	LIBS="$LIBS $MYSQL_LIBS"
fi


AC_SUBST(DEFAULT_CONFIGFILE)
AC_SUBST(DEFAULT_LOGDIR)
AC_SUBST(DEFAULT_DBHOME)
AC_SUBST(squiduser)
AC_SUBST(PERL)

AC_CONFIG_FILES([
Makefile
src/Makefile
test/Makefile
test/test1.conf
test/test2.conf
samples/Makefile
samples/sample.conf
samples/squidGuard.cgi
samples/squidGuard-simple.cgi
samples/squidGuard-simple-de.cgi
contrib/Makefile
contrib/squidGuardRobot/squidGuardRobot
contrib/sgclean/sgclean
contrib/hostbyname/hostbyname
doc/Makefile
])

AC_OUTPUT
