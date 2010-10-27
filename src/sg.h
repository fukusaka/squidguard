/*
  By accepting this notice, you agree to be bound by the following
  agreements:

  This software product, squidGuard, is copyrighted (C) 1998-2007
  by Christine Kronberg, Shalla Secure Services. All rights reserved.

  This program is free software; you can redistribute it and/or modify it
  under the terms of the GNU General Public License (version 2) as
  published by the Free Software Foundation.  It is distributed in the
  hope that it will be useful, but WITHOUT ANY WARRANTY; without even the
  implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
  PURPOSE.  See the GNU General Public License (GPL) for more details.

  You should have received a copy of the GNU General Public License
  (GPL) along with this program.
*/

#include <arpa/inet.h>
#include <assert.h>
#include <ctype.h>
#include <errno.h>
#include <netdb.h>
#include <netinet/in.h>
#include <regex.h>
#include <signal.h>
#include <stdarg.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/signal.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#include "config.h"
#include DB_HEADER

#define T_WEEKLY      1
#define T_WEEKDAY     2
#define T_TVAL        3
#define T_DVAL        4
#define T_DVALCRON    5

#define ACL_TYPE_DEFAULT    1
#define ACL_TYPE_TERMINATOR 2
#define ACL_TYPE_INADDR     3
#define ACL_TYPE_DNSBL      4

#define REQUEST_TYPE_REWRITE    1
#define REQUEST_TYPE_REDIRECT   2
#define REQUEST_TYPE_PASS       3

#define MAX_BUF 12288

#define DEFAULT_LOGFILE "squidGuard.log"
#define WARNING_LOGFILE "squidGuard.log"
#define ERROR_LOGFILE   "squidGuard.error"

#ifndef DEFAULT_CONFIGFILE
#define DEFAULT_CONFIGFILE "/usr/local/squidGuard/squidGuard.conf"
#endif

#ifndef DEFAULT_LOGDIR
#define DEFAULT_LOGDIR "/usr/local/squidGuard/log"
#endif

#ifndef DEFAULT_DBHOME
#define DEFAULT_DBHOME "/usr/local/squidGuard/db"
#endif

#define INVALID_IP_ADDR 1

#define SG_IPTYPE_HOST  1
#define SG_IPTYPE_RANGE 2
#define SG_IPTYPE_CIDR  3
#define SG_IPTYPE_CLASS 4

#define SG_BLOCK_DESTINATION 1
#define SG_BLOCK_SOURCE      2
#define SG_BLOCK_REWRITE     3
#define SG_BLOCK_ACL         4

#define REDIRECT_PERMANENT   "301:"
#define REDIRECT_TEMPORARILY "302:"

char *progname;

struct LogFileStat {
  char *name;
  FILE *fd;
  ino_t st_ino;
  dev_t st_dev;
  struct LogFileStat *next;
};

struct LogFile {
  char *parent_name;
  int parent_type;
  int anonymous;
  int verbose;
  struct LogFileStat *stat;
};

struct SquidQueue {
  struct SquidInfo *squidInfo;
  struct SquidQueue *next;
};

struct UserInfo {
  /* quota tracking */
  time_t time;
  time_t last;
  int consumed;
  char status;
#ifdef HAVE_LIBLDAP
  /* LDAP tracking */
  int ldapuser;                        /* bool: 1 if user loaded from LDAP */
  int found;                   /* bool: we also cache if not found in LDAP */
  time_t cachetime;            /* time this item was added to cache */
#endif
};

struct UserQuota {
  time_t seconds;
  int renew;
  time_t sporadic;
};

struct SquidInfo {
  char protocol[MAX_BUF];
  char domain[MAX_BUF];
  int  dot;  /* true if domain is in dot notation */
  char url[MAX_BUF];
  char orig[MAX_BUF];
  char surl[MAX_BUF];
  char furl[MAX_BUF];
  char *strippedurl;
  int  port;
  char src[MAX_BUF];
  char srcDomain[MAX_BUF];
  char ident[MAX_BUF];
  char method[MAX_BUF];
};


struct sgRegExp {
  char *pattern;
  char *substitute;
  regex_t *compiled;
  int error;
  int flags;
  int global;
  char *httpcode;
  struct sgRegExp *next;
};

struct sgRewrite {
  char *name;
  int active;
  struct sgRegExp *rewrite;
  struct LogFile *logfile;
  struct Time *time;
  int within;
  struct sgRewrite *next;
};

#define SGDBTYPE_DOMAINLIST 1
#define SGDBTYPE_URLLIST 2
#define SGDBTYPE_USERLIST 3

struct sgDb {
  char *dbhome;
  DB *dbp;
  DBC *dbcp;
  DB_ENV *dbenv;
  DBT key;
  DBT data;
  int entries;
  int type;
};

struct Ip {
  int type;
  int net_is_set;
  unsigned long net;
  int mask;
  char *str;
  struct Ip *next;
};

/* ldapip */
#ifdef HAVE_LIBLDAP
  /* LDAP tracking */
struct IpInfo {
  /* quota tracking */
  time_t time;
  time_t last;
  int consumed;
  char status;
  int ldapip;                        /* bool: 1 if ip loaded from LDAP */
  int found;                   /* bool: we also cache if not found in LDAP */
  time_t cachetime;            /* time this item was added to cache */
};
#endif

struct IpQuota {
  time_t seconds;
  int renew;
  time_t sporadic;
};
/* ldapip */


struct Setting {
  char *name;
  char *value;
  struct Setting *next;
};

struct TimeElement {
  char wday;
  int  from;
  int  to;
  int  y;
  int  m;
  int  d;
  time_t fromdate;
  time_t todate;
  struct TimeElement *next;
};

struct Time {
  char *name;
  int active;
  struct TimeElement *element;
  struct Time *next;
};

struct Destination {
  //int syslogStatus;
  char *name;
  int active;
  char *domainlist;
  struct sgDb *domainlistDb;
  char *urllist;
  struct sgDb *urllistDb;
  char *expressionlist;
  struct sgRegExp *regExp;
  struct sgRewrite *rewrite;
  char *redirect;
  struct Time *time;
  int within;
  struct LogFile *logfile;
  struct Destination *next;
};

struct Source {
  char *name;
  int active;
  struct Ip *ip;
  struct Ip *lastip;
  struct sgDb *domainDb;
  struct sgDb *userDb;
  struct Time *time;
  int within;
  int cont_search;
  struct UserQuota userquota;
  struct LogFile *logfile;
#ifdef HAVE_LIBLDAP
  struct sgDb *ipDb;
  struct IpQuota ipquota;
  char **ldapuserurls;                     /* dynamic array of url strings */
  int ldapuserurlcount;                    /* current size of pointer array */
  char **ldapipurls;                     /* dynamic array of url strings */
  int ldapipurlcount;                    /* current size of pointer array */
#endif
  struct Source *next;
};



struct Acl {
  char *name;
  int active;
  struct Source *source;
  struct AclDest *pass;
  int rewriteDefault;
  struct sgRewrite *rewrite;
  char *redirect;
  struct Time *time;
  int within;
  struct LogFile *logfile;
  struct Acl *next;
};

struct AclDest {
  char *name;
  char *dns_suffix;
  struct Destination *dest;
  int    access;
  int    type;
  struct AclDest *next;
};

int lineno;

char   *sgParseRedirect	(char *, struct SquidInfo *, struct Acl *, struct AclDest *);
char   *sgAclAccess (struct Source *, struct Acl *, struct SquidInfo *);

void   sgLogFile (int, int, int, char *);
struct LogFileStat *sgLogFileStat (char *);

void   sgReadConfig (char *);
void   sgLog (struct LogFileStat *, char *, ...);
void   sgLogDebug (char *, ...);
void   sgLogNotice (char *, ...);
void   sgLogWarn (char *, ...);
void   sgLogError (char *, ...);
void   sgLogFatal (char *, ...);
void   sgSetGlobalErrorLogFile ();
void   sgLogRequest (struct LogFile *, struct SquidInfo *, struct Acl *, struct AclDest *, struct sgRewrite *, int);
int    parseLine (char *, struct SquidInfo *);
char   *sgStripUrl (char *);

void   sgEmergency ();
void   sgReloadConfig ();
void   sgHandlerSigHUP (int);
void   sgAlarm ();
int    sgStrRcmp (char *, char *);
int    sgStrRncmp (char *, char *, int);
int    sgDomStrRncmp (char *, char *, int);
char   *sgSkipHostPart (char *);
uint32_t *sgConvDot (char *);

void   sgSource (char *);
void   sgSourceEnd ();
void   sgSourceUser (char *);
void   sgSourceUserList (char *);
void   sgSourceUserQuery (char *,char *,char *,char *);
//#ifdef HAVE_LIBLDAP
void   sgSourceLdapUserSearch (char *);
void sgSourceLdapIpSearch(char *);
//#endif
void   sgSourceExecUserList (char *);
void   sgSourceDomain (char *);
void   sgSourceIpList (char *);
struct Source *sgSourceFindName (char *);
struct Source *sgFindSource (struct Source *, char *, char *, char *);
void   sgSourceTime (char *, int);

void   sgDest (char *);
void   sgDestEnd ();
void   sgDestDomainList (char *);
void   sgDestUrlList (char *);
void   sgDestExpressionList (char *, char *);
void   sgDestRedirect (char *);
void   sgDestRewrite (char *);
struct Destination *sgDestFindName (char *);
void   sgDestTime (char *, int);

void   sgSetting (char *, char *);
#ifdef USE_SYSLOG
void   sgSyslogSetting (char *);
#endif
struct Setting *sgSettingFindName (char *);
char   *sgSettingGetValue (char *);

void   sgRewrite (char *);
void   sgRewriteSubstitute (char *);
struct sgRewrite *sgRewriteFindName (char *);
char   *sgRewriteExpression (struct sgRewrite *, char *);
void   sgRewriteTime (char *, int);

void   sgTime (char *);
struct Time *sgTimeFindName (char *);
int    sgTimeCheck (struct tm *, time_t);
void   sgTimeElementInit ();
void   sgTimeElementSortEvents ();
void   sgTimeElementAdd (char *, char);
void   sgTimeElementEnd ();
int    sgTimeNextEvent ();
void   sgTimeSetAcl ();
void   sgTimeElementClone ();
void   sgTimePrint ();

void   sgSetIpType (int, char *, int);
void   sgIp (char *);
struct Ip *sgIpLast (struct Source *);

void   sgAcl (char *, char *, int);
struct Acl *sgAclFindName (char *);
void   sgAclSetValue (char *,char *,int);
struct Acl *sgAclCheckSource (struct Source *);

struct sgRegExp *sgNewPatternBuffer (char *, int);
void   sgFreePatternBuffer (struct sgRegExp *);
int    sgRegExpMatch (struct sgRegExp *, char *);
char   *sgRegExpSubst (struct sgRegExp *, char *);

void   sgDbInit ();
void   sgDbLoadTextFile (struct sgDb *, char *, int);
void   sgDbUpdate (struct sgDb *, char *, char *, size_t);

int db_init (char *, DB_ENV **);
int    domainCompare (const DB *, const DBT *, const DBT *);

time_t date2sec (char *);
time_t iso2sec (char *);
char   *niso (time_t);
struct UserQuotaInfo *setuserquota ();
void sgSourceUserQuota (char *, char *, char *);

struct IpQuotaInfo *setipquota (); /* ldapip */
void sgSourceIpQuota (char *, char *, char *); /*ldapip */

void   *sgMalloc (size_t);
void   *sgCalloc (size_t, size_t);
void   *sgRealloc (void *, size_t);
void   sgFree (void *);

int    defined (struct sgDb *, char *, char **);

void   usage (void);

void   yyerror (char *);
int    yyparse (void);
int    yylex (void);
void   sgFreeAllLists (void);
void   sgFreeDestination (struct Destination *);
void   sgFreeSource (struct Source *);
void   sgFreeIp (struct Ip *);
void   sgFreeSetting (struct Setting *);
void   sgFreeTime (struct Time *);
void   sgFreeRewrite (struct sgRewrite *);
void   sgFreeAcl (struct Acl *);
void   sgFreeAclDest (struct AclDest *);
void   sgFreeLogFileStat (struct LogFileStat *);

int    sgFindUser (struct Source *, char *, struct UserInfo **);
#ifdef HAVE_LIBLDAP
int    sgDoLdapSearch (const char *, const char *);
int    sgFindIp (struct Source *, char *, struct IpInfo **);
#endif

int    expand_url (char *, size_t, const char *, const char *);


struct UserInfo *setuserinfo ();

