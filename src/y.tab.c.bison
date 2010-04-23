
/*  A Bison parser, made from sg.y
    by GNU Bison version 1.28  */

#define YYBISON 1  /* Identify Bison output.  */

#define	WORD	257
#define	END	258
#define	START_BRACKET	259
#define	STOP_BRACKET	260
#define	WEEKDAY	261
#define	DESTINATION	262
#define	REWRITE	263
#define	ACL	264
#define	TIME	265
#define	TVAL	266
#define	DVAL	267
#define	DVALCRON	268
#define	SOURCE	269
#define	CIDR	270
#define	IPCLASS	271
#define	CONTINUE	272
#define	IPADDR	273
#define	DBHOME	274
#define	DOMAINLIST	275
#define	URLLIST	276
#define	EXPRESSIONLIST	277
#define	IPLIST	278
#define	DOMAIN	279
#define	USER	280
#define	USERLIST	281
#define	USERQUOTA	282
#define	IP	283
#define	NL	284
#define	NUMBER	285
#define	PASS	286
#define	REDIRECT	287
#define	LOGDIR	288
#define	SUBST	289
#define	CHAR	290
#define	MINUTELY	291
#define	HOURLY	292
#define	DAILY	293
#define	WEEKLY	294
#define	DATE	295
#define	WITHIN	296
#define	OUTSIDE	297
#define	ELSE	298
#define	LOGFILE	299
#define	ANONYMOUS	300
#define	CONTINIOUS	301
#define	SPORADIC	302

#line 20 "sg.y"

#include "sg.h"

FILE *yyin, *yyout;
char *configFile;

extern struct Setting *lastSetting ;
extern struct Setting *Setting;

extern struct Source *lastSource ;
extern struct Source *Source ;

extern struct Destination *lastDest ;
extern struct Destination *Dest ;

extern struct sgRewrite *lastRewrite;
extern struct sgRewrite *Rewrite;
extern struct sgRegExp *lastRewriteRegExec;

extern struct Time *lastTime;
extern struct Time *Time;

extern struct LogFile *globalLogFile;

extern struct LogFileStat *lastLogFileStat;
extern struct LogFileStat *LogFileStat;

extern struct TimeElement *lastTimeElement;
extern struct TimeElement *TimeElement;
int numTimeElements;
int *TimeElementsEvents;
extern struct Acl *lastAcl ;
extern struct Acl *defaultAcl ;
extern struct Acl *Acl;
extern struct AclDest *lastAclDest;
 
extern struct sgRegExp *lastRegExpDest;

extern char *globalLogDir; /* from main.c */

extern struct Source *lastActiveSource;

extern int globalDebugTimeDelta;

static int time_switch = 0;
static int date_switch = 0;

int numSource = 0;


#line 71 "sg.y"
typedef union {
  char *string;
  char *tval;
  char *dval;
  char *dvalcron;
  int  *integer;
} YYSTYPE;
#include <stdio.h>

#ifndef __cplusplus
#ifndef __STDC__
#define const
#endif
#endif



#define	YYFINAL		181
#define	YYFLAG		-32768
#define	YYNTBASE	53

#define YYTRANSLATE(x) ((unsigned)(x) <= 302 ? yytranslate[x] : 101)

static const char yytranslate[] = {     0,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,    52,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,    51,    49,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,    50,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     1,     3,     4,     5,     6,
     7,     8,     9,    10,    11,    12,    13,    14,    15,    16,
    17,    18,    19,    20,    21,    22,    23,    24,    25,    26,
    27,    28,    29,    30,    31,    32,    33,    34,    35,    36,
    37,    38,    39,    40,    41,    42,    43,    44,    45,    46,
    47,    48
};

#if YYDEBUG != 0
static const short yyprhs[] = {     0,
     0,     2,     5,     8,    10,    12,    15,    20,    21,    24,
    27,    30,    33,    36,    39,    43,    46,    49,    52,    55,
    58,    62,    65,    68,    73,    74,    77,    80,    83,    86,
    91,    96,   101,   106,   109,   112,   115,   118,   122,   125,
   127,   128,   131,   134,   135,   138,   141,   146,   147,   150,
   152,   156,   160,   165,   166,   176,   177,   180,   183,   186,
   189,   193,   196,   197,   200,   204,   207,   209,   211,   212,
   215,   219,   223,   228,   231,   233,   236,   241,   242,   245,
   247,   250,   253,   257,   260,   263,   268,   269,   272,   273,
   274,   280,   281,   282,   288,   289,   293,   294,   300,   304,
   307,   309,   314,   318,   321,   323,   325,   327,   329,   330,
   333,   335,   337,   339,   341,   343,   345,   347,   349
};

static const short yyrhs[] = {    99,
     0,    20,     3,     0,    34,     3,     0,     5,     0,     6,
     0,     8,     3,     0,    58,    56,    60,    57,     0,     0,
    60,    61,     0,    21,     3,     0,    21,    49,     0,    22,
     3,     0,    22,    49,     0,    23,    49,     0,    23,    50,
     3,     0,    23,     3,     0,    33,     3,     0,     9,     3,
     0,    42,     3,     0,    43,     3,     0,    45,    46,     3,
     0,    45,     3,     0,    15,     3,     0,    62,    56,    64,
    57,     0,     0,    64,    65,     0,    25,    66,     0,    26,
    67,     0,    27,     3,     0,    28,    31,    31,    38,     0,
    28,    31,    31,    39,     0,    28,    31,    31,    40,     0,
    28,    31,    31,    31,     0,    29,    78,     0,    24,     3,
     0,    42,     3,     0,    43,     3,     0,    45,    46,     3,
     0,    45,     3,     0,    18,     0,     0,    66,     3,     0,
    66,    51,     0,     0,    67,     3,     0,    67,    51,     0,
    10,    56,    69,    57,     0,     0,    69,    71,     0,     3,
     0,     3,    42,     3,     0,     3,    43,     3,     0,    70,
    56,    73,    57,     0,     0,    70,    56,    73,    57,    44,
    72,    56,    73,    57,     0,     0,    73,    74,     0,    32,
    75,     0,     9,     3,     0,    33,     3,     0,    45,    46,
     3,     0,    45,     3,     0,     0,    75,     3,     0,    75,
    52,     3,     0,    75,    51,     0,    16,     0,    17,     0,
     0,    78,    79,     0,    78,    79,    76,     0,    78,    79,
    77,     0,    78,    79,    49,    79,     0,    78,    51,     0,
    19,     0,     9,     3,     0,    80,    56,    82,    57,     0,
     0,    82,    83,     0,    35,     0,    42,     3,     0,    43,
     3,     0,    45,    46,     3,     0,    45,     3,     0,    11,
     3,     0,    84,    56,    86,    57,     0,     0,    86,    87,
     0,     0,     0,    40,    88,     3,    89,    93,     0,     0,
     0,    40,    90,     7,    91,    93,     0,     0,    41,    92,
    95,     0,     0,    93,    94,    97,    49,    97,     0,    97,
    49,    97,     0,    96,    93,     0,    96,     0,    96,    49,
    96,    93,     0,    96,    49,    96,     0,    98,    93,     0,
    98,     0,    13,     0,    12,     0,    14,     0,     0,    99,
   100,     0,    58,     0,    63,     0,    59,     0,    54,     0,
    55,     0,    68,     0,    81,     0,    85,     0,    30,     0
};

#endif

#if YYDEBUG != 0
static const short yyrline[] = { 0,
   108,   113,   116,   119,   123,   127,   130,   134,   135,   137,
   139,   140,   141,   142,   143,   144,   145,   146,   147,   148,
   149,   150,   153,   156,   159,   160,   164,   165,   166,   167,
   169,   171,   173,   175,   176,   177,   178,   179,   180,   181,
   185,   186,   187,   190,   191,   192,   195,   198,   199,   202,
   203,   204,   207,   208,   210,   213,   214,   217,   218,   219,
   220,   221,   224,   225,   226,   227,   230,   233,   235,   236,
   237,   238,   239,   240,   243,   246,   248,   251,   252,   256,
   257,   258,   259,   260,   264,   266,   269,   270,   274,   275,
   276,   276,   277,   278,   278,   279,   282,   282,   283,   286,
   287,   288,   289,   290,   291,   294,   297,   300,   303,   304,
   307,   309,   310,   311,   312,   313,   314,   315,   316
};
#endif


#if YYDEBUG != 0 || defined (YYERROR_VERBOSE)

static const char * const yytname[] = {   "$","error","$undefined.","WORD","END",
"START_BRACKET","STOP_BRACKET","WEEKDAY","DESTINATION","REWRITE","ACL","TIME",
"TVAL","DVAL","DVALCRON","SOURCE","CIDR","IPCLASS","CONTINUE","IPADDR","DBHOME",
"DOMAINLIST","URLLIST","EXPRESSIONLIST","IPLIST","DOMAIN","USER","USERLIST",
"USERQUOTA","IP","NL","NUMBER","PASS","REDIRECT","LOGDIR","SUBST","CHAR","MINUTELY",
"HOURLY","DAILY","WEEKLY","DATE","WITHIN","OUTSIDE","ELSE","LOGFILE","ANONYMOUS",
"CONTINIOUS","SPORADIC","'-'","'i'","','","'!'","start","dbhome","logdir","start_block",
"stop_block","destination","destination_block","destination_contents","destination_content",
"source","source_block","source_contents","source_content","domain","user","acl_block",
"acl_contents","acl","acl_content","@1","access_contents","access_content","access_pass",
"cidr","ipclass","ips","ip","rew","rew_block","rew_contents","rew_content","time",
"time_block","time_contents","time_content","@2","@3","@4","@5","@6","ttime",
"@7","date","dval","tval","dvalcron","statements","statement", NULL
};
#endif

static const short yyr1[] = {     0,
    53,    54,    55,    56,    57,    58,    59,    60,    60,    61,
    61,    61,    61,    61,    61,    61,    61,    61,    61,    61,
    61,    61,    62,    63,    64,    64,    65,    65,    65,    65,
    65,    65,    65,    65,    65,    65,    65,    65,    65,    65,
    66,    66,    66,    67,    67,    67,    68,    69,    69,    70,
    70,    70,    71,    72,    71,    73,    73,    74,    74,    74,
    74,    74,    75,    75,    75,    75,    76,    77,    78,    78,
    78,    78,    78,    78,    79,    80,    81,    82,    82,    83,
    83,    83,    83,    83,    84,    85,    86,    86,    88,    89,
    87,    90,    91,    87,    92,    87,    94,    93,    93,    95,
    95,    95,    95,    95,    95,    96,    97,    98,    99,    99,
   100,   100,   100,   100,   100,   100,   100,   100,   100
};

static const short yyr2[] = {     0,
     1,     2,     2,     1,     1,     2,     4,     0,     2,     2,
     2,     2,     2,     2,     3,     2,     2,     2,     2,     2,
     3,     2,     2,     4,     0,     2,     2,     2,     2,     4,
     4,     4,     4,     2,     2,     2,     2,     3,     2,     1,
     0,     2,     2,     0,     2,     2,     4,     0,     2,     1,
     3,     3,     4,     0,     9,     0,     2,     2,     2,     2,
     3,     2,     0,     2,     3,     2,     1,     1,     0,     2,
     3,     3,     4,     2,     1,     2,     4,     0,     2,     1,
     2,     2,     3,     2,     2,     4,     0,     2,     0,     0,
     5,     0,     0,     5,     0,     3,     0,     5,     3,     2,
     1,     4,     3,     2,     1,     1,     1,     1,     0,     2,
     1,     1,     1,     1,     1,     1,     1,     1,     1
};

static const short yydefact[] = {   109,
     1,     0,     0,     0,     0,     0,     0,   119,     0,   114,
   115,   111,   113,     0,   112,   116,     0,   117,     0,   118,
   110,     6,    76,     4,    48,    85,    23,     2,     3,     8,
    25,    78,    87,     0,     0,     0,     0,     0,    50,     5,
    47,     0,    49,     0,     0,     0,     0,     0,     0,     0,
     0,     7,     9,    40,     0,    41,    44,     0,     0,    69,
     0,     0,     0,    24,    26,    80,     0,     0,     0,    77,
    79,    89,    95,    86,    88,     0,     0,    56,    18,    10,
    11,    12,    13,    16,    14,     0,    17,    19,    20,    22,
     0,    35,    27,    28,    29,     0,    34,    36,    37,    39,
     0,    81,    82,    84,     0,     0,     0,     0,    51,    52,
     0,    15,    21,    42,    43,    45,    46,     0,    75,    74,
    70,    38,    83,    90,    93,   106,   108,    96,   101,   105,
     0,    63,     0,     0,    53,    57,    33,    30,    31,    32,
    67,    68,     0,    71,    72,     0,     0,   107,     0,   100,
     0,   104,    59,    58,    60,    62,     0,    54,    73,    91,
    94,   103,     0,     0,    64,    66,     0,    61,     0,   102,
     0,    99,    65,    56,     0,     0,    98,    55,     0,     0,
     0
};

static const short yydefgoto[] = {   179,
    10,    11,    25,    41,    12,    13,    35,    53,    14,    15,
    36,    65,    93,    94,    16,    34,    42,    43,   169,   111,
   136,   154,   144,   145,    97,   121,    17,    18,    37,    71,
    19,    20,    38,    75,   106,   146,   107,   147,   108,   150,
   163,   128,   129,   151,   130,     1,    21
};

static const short yypact[] = {-32768,
    86,    19,    39,    40,    41,    43,    44,-32768,    82,-32768,
-32768,    40,-32768,    40,-32768,-32768,    40,-32768,    40,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,
-32768,-32768,-32768,    20,    60,    47,    35,    73,    -5,-32768,
-32768,    40,-32768,    83,    11,    12,     9,    84,    85,    88,
    10,-32768,-32768,-32768,    95,-32768,-32768,    96,    76,-32768,
   101,   105,    16,-32768,-32768,-32768,   106,   107,    17,-32768,
-32768,   104,-32768,-32768,-32768,   109,   112,-32768,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,   114,-32768,-32768,-32768,-32768,
   115,-32768,     0,     1,-32768,    90,    49,-32768,-32768,-32768,
   116,-32768,-32768,-32768,   119,   120,   117,    26,-32768,-32768,
    22,-32768,-32768,-32768,-32768,-32768,-32768,    -4,-32768,-32768,
     8,-32768,-32768,-32768,-32768,-32768,-32768,-32768,    -6,   113,
   123,-32768,   124,    18,    87,-32768,-32768,-32768,-32768,-32768,
-32768,-32768,   110,-32768,-32768,   113,   113,-32768,   121,   118,
    79,   118,-32768,    -2,-32768,-32768,   129,-32768,-32768,   118,
   118,   113,   113,   113,-32768,-32768,   130,-32768,    40,   118,
    89,-32768,-32768,-32768,   113,    22,-32768,-32768,   135,   136,
-32768
};

static const short yypgoto[] = {-32768,
-32768,-32768,   -12,   -27,-32768,-32768,-32768,-32768,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,   -37,
-32768,-32768,-32768,-32768,-32768,    -3,-32768,-32768,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,  -114,
-32768,-32768,   -10,  -146,-32768,-32768,-32768
};


#define	YYLAST		157


static const short yytable[] = {    30,
   165,    31,   114,   116,    32,   148,    33,    52,    64,    70,
    74,    84,    90,    80,    82,   152,   171,   172,   100,   104,
   156,    22,    39,   141,   142,    40,   137,    40,   177,    78,
   131,   160,   161,   138,   139,   140,    76,    77,   126,   127,
    40,    23,   149,    26,    24,    27,    28,   170,   166,   167,
   115,   117,    40,   132,   133,    91,   143,    85,    86,    81,
    83,   101,   105,   157,    54,    40,   134,   119,    44,    66,
    55,    56,    57,    58,    59,    60,    67,    68,    40,    69,
    45,    46,    47,   135,    29,    79,    87,    88,    61,    62,
    89,    63,    48,     2,     3,     4,     5,    92,    95,   120,
     6,    49,    50,    98,    51,     7,    96,    99,   102,   103,
   -92,   109,    72,    73,   110,     8,   112,   113,   122,     9,
   118,   123,   124,   125,   148,   153,   155,   164,   119,   -97,
   158,   168,   173,   126,   180,   181,   176,   175,   162,   159,
     0,     0,     0,     0,     0,     0,     0,     0,   178,     0,
     0,     0,     0,     0,     0,     0,   174
};

static const short yycheck[] = {    12,
     3,    14,     3,     3,    17,    12,    19,    35,    36,    37,
    38,     3,     3,     3,     3,   130,   163,   164,     3,     3,
     3,     3,     3,    16,    17,     6,    31,     6,   175,    42,
     9,   146,   147,    38,    39,    40,    42,    43,    13,    14,
     6,     3,    49,     3,     5,     3,     3,   162,    51,    52,
    51,    51,     6,    32,    33,    46,    49,    49,    50,    49,
    49,    46,    46,    46,    18,     6,    45,    19,     9,    35,
    24,    25,    26,    27,    28,    29,    42,    43,     6,    45,
    21,    22,    23,   111,     3,     3,     3,     3,    42,    43,
     3,    45,    33,     8,     9,    10,    11,     3,     3,    51,
    15,    42,    43,     3,    45,    20,    31,     3,     3,     3,
     7,     3,    40,    41,     3,    30,     3,     3,     3,    34,
    31,     3,     3,     7,    12,     3,     3,    49,    19,    12,
    44,     3,     3,    13,     0,     0,   174,    49,   149,   143,
    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,   176,    -1,
    -1,    -1,    -1,    -1,    -1,    -1,   169
};
/* -*-C-*-  Note some compilers choke on comments on `#line' lines.  */
#line 3 "/local/share/bison.simple"
/* This file comes from bison-1.28.  */

/* Skeleton output parser for bison,
   Copyright (C) 1984, 1989, 1990 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place - Suite 330,
   Boston, MA 02111-1307, USA.  */

/* As a special exception, when this file is copied by Bison into a
   Bison output file, you may use that output file without restriction.
   This special exception was added by the Free Software Foundation
   in version 1.24 of Bison.  */

/* This is the parser code that is written into each bison parser
  when the %semantic_parser declaration is not specified in the grammar.
  It was written by Richard Stallman by simplifying the hairy parser
  used when %semantic_parser is specified.  */

#ifndef YYSTACK_USE_ALLOCA
#ifdef alloca
#define YYSTACK_USE_ALLOCA
#else /* alloca not defined */
#ifdef __GNUC__
#define YYSTACK_USE_ALLOCA
#define alloca __builtin_alloca
#else /* not GNU C.  */
#if (!defined (__STDC__) && defined (sparc)) || defined (__sparc__) || defined (__sparc) || defined (__sgi) || (defined (__sun) && defined (__i386))
#define YYSTACK_USE_ALLOCA
#include <alloca.h>
#else /* not sparc */
/* We think this test detects Watcom and Microsoft C.  */
/* This used to test MSDOS, but that is a bad idea
   since that symbol is in the user namespace.  */
#if (defined (_MSDOS) || defined (_MSDOS_)) && !defined (__TURBOC__)
#if 0 /* No need for malloc.h, which pollutes the namespace;
	 instead, just don't use alloca.  */
#include <malloc.h>
#endif
#else /* not MSDOS, or __TURBOC__ */
#if defined(_AIX)
/* I don't know what this was needed for, but it pollutes the namespace.
   So I turned it off.   rms, 2 May 1997.  */
/* #include <malloc.h>  */
 #pragma alloca
#define YYSTACK_USE_ALLOCA
#else /* not MSDOS, or __TURBOC__, or _AIX */
#if 0
#ifdef __hpux /* haible@ilog.fr says this works for HPUX 9.05 and up,
		 and on HPUX 10.  Eventually we can turn this on.  */
#define YYSTACK_USE_ALLOCA
#define alloca __builtin_alloca
#endif /* __hpux */
#endif
#endif /* not _AIX */
#endif /* not MSDOS, or __TURBOC__ */
#endif /* not sparc */
#endif /* not GNU C */
#endif /* alloca not defined */
#endif /* YYSTACK_USE_ALLOCA not defined */

#ifdef YYSTACK_USE_ALLOCA
#define YYSTACK_ALLOC alloca
#else
#define YYSTACK_ALLOC malloc
#endif

/* Note: there must be only one dollar sign in this file.
   It is replaced by the list of actions, each action
   as one case of the switch.  */

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		-2
#define YYEOF		0
#define YYACCEPT	goto yyacceptlab
#define YYABORT 	goto yyabortlab
#define YYERROR		goto yyerrlab1
/* Like YYERROR except do call yyerror.
   This remains here temporarily to ease the
   transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */
#define YYFAIL		goto yyerrlab
#define YYRECOVERING()  (!!yyerrstatus)
#define YYBACKUP(token, value) \
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    { yychar = (token), yylval = (value);			\
      yychar1 = YYTRANSLATE (yychar);				\
      YYPOPSTACK;						\
      goto yybackup;						\
    }								\
  else								\
    { yyerror ("syntax error: cannot back up"); YYERROR; }	\
while (0)

#define YYTERROR	1
#define YYERRCODE	256

#ifndef YYPURE
#define YYLEX		yylex()
#endif

#ifdef YYPURE
#ifdef YYLSP_NEEDED
#ifdef YYLEX_PARAM
#define YYLEX		yylex(&yylval, &yylloc, YYLEX_PARAM)
#else
#define YYLEX		yylex(&yylval, &yylloc)
#endif
#else /* not YYLSP_NEEDED */
#ifdef YYLEX_PARAM
#define YYLEX		yylex(&yylval, YYLEX_PARAM)
#else
#define YYLEX		yylex(&yylval)
#endif
#endif /* not YYLSP_NEEDED */
#endif

/* If nonreentrant, generate the variables here */

#ifndef YYPURE

int	yychar;			/*  the lookahead symbol		*/
YYSTYPE	yylval;			/*  the semantic value of the		*/
				/*  lookahead symbol			*/

#ifdef YYLSP_NEEDED
YYLTYPE yylloc;			/*  location data for the lookahead	*/
				/*  symbol				*/
#endif

int yynerrs;			/*  number of parse errors so far       */
#endif  /* not YYPURE */

#if YYDEBUG != 0
int yydebug;			/*  nonzero means print parse trace	*/
/* Since this is uninitialized, it does not stop multiple parsers
   from coexisting.  */
#endif

/*  YYINITDEPTH indicates the initial size of the parser's stacks	*/

#ifndef	YYINITDEPTH
#define YYINITDEPTH 200
#endif

/*  YYMAXDEPTH is the maximum size the stacks can grow to
    (effective only if the built-in stack extension method is used).  */

#if YYMAXDEPTH == 0
#undef YYMAXDEPTH
#endif

#ifndef YYMAXDEPTH
#define YYMAXDEPTH 10000
#endif

/* Define __yy_memcpy.  Note that the size argument
   should be passed with type unsigned int, because that is what the non-GCC
   definitions require.  With GCC, __builtin_memcpy takes an arg
   of type size_t, but it can handle unsigned int.  */

#if __GNUC__ > 1		/* GNU C and GNU C++ define this.  */
#define __yy_memcpy(TO,FROM,COUNT)	__builtin_memcpy(TO,FROM,COUNT)
#else				/* not GNU C or C++ */
#ifndef __cplusplus

/* This is the most reliable way to avoid incompatibilities
   in available built-in functions on various systems.  */
static void
__yy_memcpy (to, from, count)
     char *to;
     char *from;
     unsigned int count;
{
  register char *f = from;
  register char *t = to;
  register int i = count;

  while (i-- > 0)
    *t++ = *f++;
}

#else /* __cplusplus */

/* This is the most reliable way to avoid incompatibilities
   in available built-in functions on various systems.  */
static void
__yy_memcpy (char *to, char *from, unsigned int count)
{
  register char *t = to;
  register char *f = from;
  register int i = count;

  while (i-- > 0)
    *t++ = *f++;
}

#endif
#endif

#line 217 "/local/share/bison.simple"

/* The user can define YYPARSE_PARAM as the name of an argument to be passed
   into yyparse.  The argument should have type void *.
   It should actually point to an object.
   Grammar actions can access the variable by casting it
   to the proper pointer type.  */

#ifdef YYPARSE_PARAM
#ifdef __cplusplus
#define YYPARSE_PARAM_ARG void *YYPARSE_PARAM
#define YYPARSE_PARAM_DECL
#else /* not __cplusplus */
#define YYPARSE_PARAM_ARG YYPARSE_PARAM
#define YYPARSE_PARAM_DECL void *YYPARSE_PARAM;
#endif /* not __cplusplus */
#else /* not YYPARSE_PARAM */
#define YYPARSE_PARAM_ARG
#define YYPARSE_PARAM_DECL
#endif /* not YYPARSE_PARAM */

/* Prevent warning if -Wstrict-prototypes.  */
#ifdef __GNUC__
#ifdef YYPARSE_PARAM
int yyparse (void *);
#else
int yyparse (void);
#endif
#endif

int
yyparse(YYPARSE_PARAM_ARG)
     YYPARSE_PARAM_DECL
{
  register int yystate;
  register int yyn;
  register short *yyssp;
  register YYSTYPE *yyvsp;
  int yyerrstatus;	/*  number of tokens to shift before error messages enabled */
  int yychar1 = 0;		/*  lookahead token as an internal (translated) token number */

  short	yyssa[YYINITDEPTH];	/*  the state stack			*/
  YYSTYPE yyvsa[YYINITDEPTH];	/*  the semantic value stack		*/

  short *yyss = yyssa;		/*  refer to the stacks thru separate pointers */
  YYSTYPE *yyvs = yyvsa;	/*  to allow yyoverflow to reallocate them elsewhere */

#ifdef YYLSP_NEEDED
  YYLTYPE yylsa[YYINITDEPTH];	/*  the location stack			*/
  YYLTYPE *yyls = yylsa;
  YYLTYPE *yylsp;

#define YYPOPSTACK   (yyvsp--, yyssp--, yylsp--)
#else
#define YYPOPSTACK   (yyvsp--, yyssp--)
#endif

  int yystacksize = YYINITDEPTH;
  int yyfree_stacks = 0;

#ifdef YYPURE
  int yychar;
  YYSTYPE yylval;
  int yynerrs;
#ifdef YYLSP_NEEDED
  YYLTYPE yylloc;
#endif
#endif

  YYSTYPE yyval;		/*  the variable used to return		*/
				/*  semantic values from the action	*/
				/*  routines				*/

  int yylen;

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Starting parse\n");
#endif

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss - 1;
  yyvsp = yyvs;
#ifdef YYLSP_NEEDED
  yylsp = yyls;
#endif

/* Push a new state, which is found in  yystate  .  */
/* In all cases, when you get here, the value and location stacks
   have just been pushed. so pushing a state here evens the stacks.  */
yynewstate:

  *++yyssp = yystate;

  if (yyssp >= yyss + yystacksize - 1)
    {
      /* Give user a chance to reallocate the stack */
      /* Use copies of these so that the &'s don't force the real ones into memory. */
      YYSTYPE *yyvs1 = yyvs;
      short *yyss1 = yyss;
#ifdef YYLSP_NEEDED
      YYLTYPE *yyls1 = yyls;
#endif

      /* Get the current used size of the three stacks, in elements.  */
      int size = yyssp - yyss + 1;

#ifdef yyoverflow
      /* Each stack pointer address is followed by the size of
	 the data in use in that stack, in bytes.  */
#ifdef YYLSP_NEEDED
      /* This used to be a conditional around just the two extra args,
	 but that might be undefined if yyoverflow is a macro.  */
      yyoverflow("parser stack overflow",
		 &yyss1, size * sizeof (*yyssp),
		 &yyvs1, size * sizeof (*yyvsp),
		 &yyls1, size * sizeof (*yylsp),
		 &yystacksize);
#else
      yyoverflow("parser stack overflow",
		 &yyss1, size * sizeof (*yyssp),
		 &yyvs1, size * sizeof (*yyvsp),
		 &yystacksize);
#endif

      yyss = yyss1; yyvs = yyvs1;
#ifdef YYLSP_NEEDED
      yyls = yyls1;
#endif
#else /* no yyoverflow */
      /* Extend the stack our own way.  */
      if (yystacksize >= YYMAXDEPTH)
	{
	  yyerror("parser stack overflow");
	  if (yyfree_stacks)
	    {
	      free (yyss);
	      free (yyvs);
#ifdef YYLSP_NEEDED
	      free (yyls);
#endif
	    }
	  return 2;
	}
      yystacksize *= 2;
      if (yystacksize > YYMAXDEPTH)
	yystacksize = YYMAXDEPTH;
#ifndef YYSTACK_USE_ALLOCA
      yyfree_stacks = 1;
#endif
      yyss = (short *) YYSTACK_ALLOC (yystacksize * sizeof (*yyssp));
      __yy_memcpy ((char *)yyss, (char *)yyss1,
		   size * (unsigned int) sizeof (*yyssp));
      yyvs = (YYSTYPE *) YYSTACK_ALLOC (yystacksize * sizeof (*yyvsp));
      __yy_memcpy ((char *)yyvs, (char *)yyvs1,
		   size * (unsigned int) sizeof (*yyvsp));
#ifdef YYLSP_NEEDED
      yyls = (YYLTYPE *) YYSTACK_ALLOC (yystacksize * sizeof (*yylsp));
      __yy_memcpy ((char *)yyls, (char *)yyls1,
		   size * (unsigned int) sizeof (*yylsp));
#endif
#endif /* no yyoverflow */

      yyssp = yyss + size - 1;
      yyvsp = yyvs + size - 1;
#ifdef YYLSP_NEEDED
      yylsp = yyls + size - 1;
#endif

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Stack size increased to %d\n", yystacksize);
#endif

      if (yyssp >= yyss + yystacksize - 1)
	YYABORT;
    }

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Entering state %d\n", yystate);
#endif

  goto yybackup;
 yybackup:

/* Do appropriate processing given the current state.  */
/* Read a lookahead token if we need one and don't already have one.  */
/* yyresume: */

  /* First try to decide what to do without reference to lookahead token.  */

  yyn = yypact[yystate];
  if (yyn == YYFLAG)
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* yychar is either YYEMPTY or YYEOF
     or a valid token in external form.  */

  if (yychar == YYEMPTY)
    {
#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Reading a token: ");
#endif
      yychar = YYLEX;
    }

  /* Convert token to internal form (in yychar1) for indexing tables with */

  if (yychar <= 0)		/* This means end of input. */
    {
      yychar1 = 0;
      yychar = YYEOF;		/* Don't call YYLEX any more */

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Now at end of input.\n");
#endif
    }
  else
    {
      yychar1 = YYTRANSLATE(yychar);

#if YYDEBUG != 0
      if (yydebug)
	{
	  fprintf (stderr, "Next token is %d (%s", yychar, yytname[yychar1]);
	  /* Give the individual parser a way to print the precise meaning
	     of a token, for further debugging info.  */
#ifdef YYPRINT
	  YYPRINT (stderr, yychar, yylval);
#endif
	  fprintf (stderr, ")\n");
	}
#endif
    }

  yyn += yychar1;
  if (yyn < 0 || yyn > YYLAST || yycheck[yyn] != yychar1)
    goto yydefault;

  yyn = yytable[yyn];

  /* yyn is what to do for this token type in this state.
     Negative => reduce, -yyn is rule number.
     Positive => shift, yyn is new state.
       New state is final state => don't bother to shift,
       just return success.
     0, or most negative number => error.  */

  if (yyn < 0)
    {
      if (yyn == YYFLAG)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }
  else if (yyn == 0)
    goto yyerrlab;

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Shift the lookahead token.  */

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Shifting token %d (%s), ", yychar, yytname[yychar1]);
#endif

  /* Discard the token being shifted unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  *++yyvsp = yylval;
#ifdef YYLSP_NEEDED
  *++yylsp = yylloc;
#endif

  /* count tokens shifted since error; after three, turn off error status.  */
  if (yyerrstatus) yyerrstatus--;

  yystate = yyn;
  goto yynewstate;

/* Do the default action for the current state.  */
yydefault:

  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;

/* Do a reduction.  yyn is the number of a rule to reduce with.  */
yyreduce:
  yylen = yyr2[yyn];
  if (yylen > 0)
    yyval = yyvsp[1-yylen]; /* implement default value of the action */

#if YYDEBUG != 0
  if (yydebug)
    {
      int i;

      fprintf (stderr, "Reducing via rule %d (line %d), ",
	       yyn, yyrline[yyn]);

      /* Print the symbols being reduced, and their result.  */
      for (i = yyprhs[yyn]; yyrhs[i] > 0; i++)
	fprintf (stderr, "%s ", yytname[yyrhs[i]]);
      fprintf (stderr, " -> %s\n", yytname[yyr1[yyn]]);
    }
#endif


  switch (yyn) {

case 2:
#line 113 "sg.y"
{ sgSetting("dbhome",yyvsp[0].string); ;
    break;}
case 3:
#line 116 "sg.y"
{ sgSetting("logdir",yyvsp[0].string); ;
    break;}
case 6:
#line 127 "sg.y"
{ sgDest(yyvsp[0].string); ;
    break;}
case 7:
#line 131 "sg.y"
{ sgDestEnd();;
    break;}
case 10:
#line 138 "sg.y"
{ sgDestDomainList(yyvsp[0].string); ;
    break;}
case 11:
#line 139 "sg.y"
{ sgDestDomainList(NULL); ;
    break;}
case 12:
#line 140 "sg.y"
{ sgDestUrlList(yyvsp[0].string); ;
    break;}
case 13:
#line 141 "sg.y"
{ sgDestUrlList(NULL); ;
    break;}
case 14:
#line 142 "sg.y"
{ sgDestExpressionList(NULL,NULL); ;
    break;}
case 15:
#line 143 "sg.y"
{ sgDestExpressionList(yyvsp[0].string,"i"); ;
    break;}
case 16:
#line 144 "sg.y"
{ sgDestExpressionList(yyvsp[0].string,"n"); ;
    break;}
case 17:
#line 145 "sg.y"
{sgDestRedirect(yyvsp[0].string); ;
    break;}
case 18:
#line 146 "sg.y"
{sgDestRewrite(yyvsp[0].string); ;
    break;}
case 19:
#line 147 "sg.y"
{ sgDestTime(yyvsp[0].string,WITHIN); ;
    break;}
case 20:
#line 148 "sg.y"
{ sgDestTime(yyvsp[0].string,OUTSIDE); ;
    break;}
case 21:
#line 149 "sg.y"
{ sgLogFile(SG_BLOCK_DESTINATION,1,yyvsp[0].string); ;
    break;}
case 22:
#line 150 "sg.y"
{ sgLogFile(SG_BLOCK_DESTINATION,0,yyvsp[0].string); ;
    break;}
case 23:
#line 153 "sg.y"
{ sgSource(yyvsp[0].string); ;
    break;}
case 24:
#line 156 "sg.y"
{sgSourceEnd();;
    break;}
case 29:
#line 166 "sg.y"
{ sgSourceUserList(yyvsp[0].string); ;
    break;}
case 30:
#line 167 "sg.y"
{ 
		      sgSourceUserQuota(yyvsp[-2].string,yyvsp[-1].string,"3600");;
    break;}
case 31:
#line 169 "sg.y"
{ 
		      sgSourceUserQuota(yyvsp[-2].string,yyvsp[-1].string,"86400");;
    break;}
case 32:
#line 171 "sg.y"
{ 
		      sgSourceUserQuota(yyvsp[-2].string,yyvsp[-1].string,"604800");;
    break;}
case 33:
#line 173 "sg.y"
{ 
		      sgSourceUserQuota(yyvsp[-2].string,yyvsp[-1].string,yyvsp[0].string);;
    break;}
case 35:
#line 176 "sg.y"
{ sgSourceIpList(yyvsp[0].string); ;
    break;}
case 36:
#line 177 "sg.y"
{ sgSourceTime(yyvsp[0].string,WITHIN); ;
    break;}
case 37:
#line 178 "sg.y"
{ sgSourceTime(yyvsp[0].string,OUTSIDE); ;
    break;}
case 38:
#line 179 "sg.y"
{sgLogFile(SG_BLOCK_SOURCE,1,yyvsp[0].string);;
    break;}
case 39:
#line 180 "sg.y"
{ sgLogFile(SG_BLOCK_SOURCE,0,yyvsp[0].string); ;
    break;}
case 40:
#line 181 "sg.y"
{ lastSource->cont_search = 1; ;
    break;}
case 42:
#line 186 "sg.y"
{ sgSourceDomain(yyvsp[0].string); ;
    break;}
case 45:
#line 191 "sg.y"
{ sgSourceUser(yyvsp[0].string); ;
    break;}
case 50:
#line 202 "sg.y"
{sgAcl(yyvsp[0].string,NULL,0);;
    break;}
case 51:
#line 203 "sg.y"
{sgAcl(yyvsp[-2].string,yyvsp[0].string,WITHIN);;
    break;}
case 52:
#line 204 "sg.y"
{ sgAcl(yyvsp[-2].string,yyvsp[0].string,OUTSIDE); ;
    break;}
case 54:
#line 209 "sg.y"
{sgAcl(NULL,NULL,ELSE);;
    break;}
case 58:
#line 217 "sg.y"
{ ;
    break;}
case 59:
#line 218 "sg.y"
{ sgAclSetValue("rewrite",yyvsp[0].string,0); ;
    break;}
case 60:
#line 219 "sg.y"
{ sgAclSetValue("redirect",yyvsp[0].string,0); ;
    break;}
case 61:
#line 220 "sg.y"
{sgLogFile(SG_BLOCK_ACL,1,yyvsp[0].string);;
    break;}
case 62:
#line 221 "sg.y"
{ sgLogFile(SG_BLOCK_ACL,0,yyvsp[0].string); ;
    break;}
case 64:
#line 225 "sg.y"
{ sgAclSetValue("pass",yyvsp[0].string,1);;
    break;}
case 65:
#line 226 "sg.y"
{ sgAclSetValue("pass",yyvsp[0].string,0);;
    break;}
case 67:
#line 230 "sg.y"
{ sgIp(yyvsp[0].string); ;
    break;}
case 68:
#line 233 "sg.y"
{ sgIp(yyvsp[0].string); ;
    break;}
case 70:
#line 236 "sg.y"
{ sgIp("255.255.255.255") ; sgSetIpType(SG_IPTYPE_HOST,NULL,0); ;
    break;}
case 71:
#line 237 "sg.y"
{ sgSetIpType(SG_IPTYPE_CIDR,NULL,0); ;
    break;}
case 72:
#line 238 "sg.y"
{ sgSetIpType(SG_IPTYPE_CLASS,NULL,0); ;
    break;}
case 73:
#line 239 "sg.y"
{ sgSetIpType(SG_IPTYPE_RANGE,NULL,0); ;
    break;}
case 75:
#line 243 "sg.y"
{ sgIp(yyvsp[0].string);;
    break;}
case 76:
#line 246 "sg.y"
{ sgRewrite(yyvsp[0].string); ;
    break;}
case 80:
#line 256 "sg.y"
{ sgRewriteSubstitute(yyvsp[0].string); ;
    break;}
case 81:
#line 257 "sg.y"
{ sgRewriteTime(yyvsp[0].string,WITHIN); ;
    break;}
case 82:
#line 258 "sg.y"
{ sgRewriteTime(yyvsp[0].string,OUTSIDE); ;
    break;}
case 83:
#line 259 "sg.y"
{ sgLogFile(SG_BLOCK_REWRITE,1,yyvsp[0].string); ;
    break;}
case 84:
#line 260 "sg.y"
{ sgLogFile(SG_BLOCK_REWRITE,0,yyvsp[0].string); ;
    break;}
case 85:
#line 264 "sg.y"
{ sgTime(yyvsp[0].string); ;
    break;}
case 89:
#line 274 "sg.y"
{sgTimeElementInit();;
    break;}
case 90:
#line 275 "sg.y"
{sgTimeElementAdd(yyvsp[0].string,T_WEEKLY);;
    break;}
case 92:
#line 276 "sg.y"
{sgTimeElementInit();;
    break;}
case 93:
#line 277 "sg.y"
{sgTimeElementAdd(yyvsp[0].string,T_WEEKDAY);;
    break;}
case 95:
#line 278 "sg.y"
{sgTimeElementInit();;
    break;}
case 96:
#line 279 "sg.y"
{sgTimeElementEnd();;
    break;}
case 97:
#line 282 "sg.y"
{ sgTimeElementClone(); ;
    break;}
case 106:
#line 294 "sg.y"
{ sgTimeElementAdd(yyvsp[0].string,T_DVAL);;
    break;}
case 107:
#line 297 "sg.y"
{ sgTimeElementAdd(yyvsp[0].tval,T_TVAL);;
    break;}
case 108:
#line 300 "sg.y"
{ sgTimeElementAdd(yyvsp[0].string,T_DVALCRON);;
    break;}
}
   /* the action file gets copied in in place of this dollarsign */
#line 543 "/local/share/bison.simple"

  yyvsp -= yylen;
  yyssp -= yylen;
#ifdef YYLSP_NEEDED
  yylsp -= yylen;
#endif

#if YYDEBUG != 0
  if (yydebug)
    {
      short *ssp1 = yyss - 1;
      fprintf (stderr, "state stack now");
      while (ssp1 != yyssp)
	fprintf (stderr, " %d", *++ssp1);
      fprintf (stderr, "\n");
    }
#endif

  *++yyvsp = yyval;

#ifdef YYLSP_NEEDED
  yylsp++;
  if (yylen == 0)
    {
      yylsp->first_line = yylloc.first_line;
      yylsp->first_column = yylloc.first_column;
      yylsp->last_line = (yylsp-1)->last_line;
      yylsp->last_column = (yylsp-1)->last_column;
      yylsp->text = 0;
    }
  else
    {
      yylsp->last_line = (yylsp+yylen-1)->last_line;
      yylsp->last_column = (yylsp+yylen-1)->last_column;
    }
#endif

  /* Now "shift" the result of the reduction.
     Determine what state that goes to,
     based on the state we popped back to
     and the rule number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTBASE] + *yyssp;
  if (yystate >= 0 && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTBASE];

  goto yynewstate;

yyerrlab:   /* here on detecting error */

  if (! yyerrstatus)
    /* If not already recovering from an error, report this error.  */
    {
      ++yynerrs;

#ifdef YYERROR_VERBOSE
      yyn = yypact[yystate];

      if (yyn > YYFLAG && yyn < YYLAST)
	{
	  int size = 0;
	  char *msg;
	  int x, count;

	  count = 0;
	  /* Start X at -yyn if nec to avoid negative indexes in yycheck.  */
	  for (x = (yyn < 0 ? -yyn : 0);
	       x < (sizeof(yytname) / sizeof(char *)); x++)
	    if (yycheck[x + yyn] == x)
	      size += strlen(yytname[x]) + 15, count++;
	  msg = (char *) malloc(size + 15);
	  if (msg != 0)
	    {
	      strcpy(msg, "parse error");

	      if (count < 5)
		{
		  count = 0;
		  for (x = (yyn < 0 ? -yyn : 0);
		       x < (sizeof(yytname) / sizeof(char *)); x++)
		    if (yycheck[x + yyn] == x)
		      {
			strcat(msg, count == 0 ? ", expecting `" : " or `");
			strcat(msg, yytname[x]);
			strcat(msg, "'");
			count++;
		      }
		}
	      yyerror(msg);
	      free(msg);
	    }
	  else
	    yyerror ("parse error; also virtual memory exceeded");
	}
      else
#endif /* YYERROR_VERBOSE */
	yyerror("parse error");
    }

  goto yyerrlab1;
yyerrlab1:   /* here on error raised explicitly by an action */

  if (yyerrstatus == 3)
    {
      /* if just tried and failed to reuse lookahead token after an error, discard it.  */

      /* return failure if at end of input */
      if (yychar == YYEOF)
	YYABORT;

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Discarding token %d (%s).\n", yychar, yytname[yychar1]);
#endif

      yychar = YYEMPTY;
    }

  /* Else will try to reuse lookahead token
     after shifting the error token.  */

  yyerrstatus = 3;		/* Each real token shifted decrements this */

  goto yyerrhandle;

yyerrdefault:  /* current state does not do anything special for the error token. */

#if 0
  /* This is wrong; only states that explicitly want error tokens
     should shift them.  */
  yyn = yydefact[yystate];  /* If its default is to accept any token, ok.  Otherwise pop it.*/
  if (yyn) goto yydefault;
#endif

yyerrpop:   /* pop the current state because it cannot handle the error token */

  if (yyssp == yyss) YYABORT;
  yyvsp--;
  yystate = *--yyssp;
#ifdef YYLSP_NEEDED
  yylsp--;
#endif

#if YYDEBUG != 0
  if (yydebug)
    {
      short *ssp1 = yyss - 1;
      fprintf (stderr, "Error: state stack now");
      while (ssp1 != yyssp)
	fprintf (stderr, " %d", *++ssp1);
      fprintf (stderr, "\n");
    }
#endif

yyerrhandle:

  yyn = yypact[yystate];
  if (yyn == YYFLAG)
    goto yyerrdefault;

  yyn += YYTERROR;
  if (yyn < 0 || yyn > YYLAST || yycheck[yyn] != YYTERROR)
    goto yyerrdefault;

  yyn = yytable[yyn];
  if (yyn < 0)
    {
      if (yyn == YYFLAG)
	goto yyerrpop;
      yyn = -yyn;
      goto yyreduce;
    }
  else if (yyn == 0)
    goto yyerrpop;

  if (yyn == YYFINAL)
    YYACCEPT;

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Shifting error token, ");
#endif

  *++yyvsp = yylval;
#ifdef YYLSP_NEEDED
  *++yylsp = yylloc;
#endif

  yystate = yyn;
  goto yynewstate;

 yyacceptlab:
  /* YYACCEPT comes here.  */
  if (yyfree_stacks)
    {
      free (yyss);
      free (yyvs);
#ifdef YYLSP_NEEDED
      free (yyls);
#endif
    }
  return 0;

 yyabortlab:
  /* YYABORT comes here.  */
  if (yyfree_stacks)
    {
      free (yyss);
      free (yyvs);
#ifdef YYLSP_NEEDED
      free (yyls);
#endif
    }
  return 1;
}
#line 319 "sg.y"


#if __STDC__
void sgReadConfig (char *file)
#else
void sgReadConfig (file)
     char *file;
#endif
{
  char *defaultFile=DEFAULT_CONFIGFILE;
  lineno = 1;
  configFile = file;
  if(configFile == NULL)
    configFile = defaultFile;
  yyin = fopen(configFile,"r");
  if(yyin == NULL) 
    sgLogFatalError("%s: can't open configfile  %s",progname, configFile);
  (void)yyparse();
  if(defaultAcl == NULL)
    sgLogFatalError("%s: default acl not defined in configfile  %s",
	progname, configFile);
  fclose(yyin);
}


/*
  
  Logfile functions

*/

#if __STDC__
void sgLogFile (int block, int anonymous, char *file)
#else
void sgLogFile (block, anonymous, file)
     int block;
     int anonymous;
     char *file;
#endif
{
  void **v;
  char *name;
  struct LogFile *p;
  switch(block){
  case(SG_BLOCK_DESTINATION):
    v = (void **) &lastDest->logfile;
    name = lastDest->name;
    break;
  case(SG_BLOCK_SOURCE):
    v = (void **) &lastSource->logfile;
    name = lastSource->name;
    break;
  case(SG_BLOCK_REWRITE):
    v = (void **) &lastRewrite->logfile;
    name = lastRewrite->name;
    break;
  case(SG_BLOCK_ACL):
    v = (void **) &lastAcl->logfile;
    name = lastAcl->name;
    if(strcmp(name,"default")){
      sgLogError("logfile not allowed in acl other than default");
    }
    break;
  default:
    return;
  }
  if(*v == NULL){
    p = (struct LogFile *) sgCalloc(1,sizeof(struct LogFile));
    p->stat = sgLogFileStat(file);
    p->parent_name = name;
    p->parent_type = block;
    p->anonymous = anonymous;
    *v = p;
  } else {
    sgLogError("%s: redefine of logfile %s in line %d",
		    progname,file,lineno);
    return;
  }
}

#if __STDC__
struct LogFileStat *sgLogFileStat(char *file)
#else
struct LogFileStat *sgLogFileStat(file)
     char *file;
#endif
{
  struct LogFileStat *sg;
  struct stat s;
  char buf[MAX_BUF];
  FILE *fd;
  strncpy(buf,file,MAX_BUF);
  if(*file != '/'){
    if(globalLogDir == NULL)
      strncpy(buf,DEFAULT_LOGDIR,MAX_BUF);
    else
      strncpy(buf,globalLogDir,MAX_BUF);
    strcat(buf,"/");
    strcat(buf,file);
  }
  if((fd = fopen(buf, "a")) == NULL){
    sgLogError("%s: can't write to logfile %s",progname,buf);
    return NULL;
  }
  if(stat(buf,&s) != 0){
    sgLogError("%s: can't stat logfile %s",progname,buf);
    return NULL;
  }
  if(LogFileStat == NULL){
    sg = (struct LogFileStat *) sgCalloc(1,sizeof(struct LogFileStat));
    sg->name = sgMalloc(strlen(buf) + 1);
    strcpy(sg->name,buf);
    sg->st_ino = s.st_ino;
    sg->st_dev = s.st_dev;
    sg->fd = fd;
    sg->next = NULL;
    LogFileStat = sg;
    lastLogFileStat = sg;
  } else {
    for(sg = LogFileStat; sg != NULL; sg = sg->next){
      if(sg->st_ino == s.st_ino && sg->st_dev == s.st_dev){
	fclose(fd);
	return sg;
      }
    }
    sg = (struct LogFileStat *) sgCalloc(1,sizeof(struct LogFileStat));
    sg->name = sgMalloc(strlen(buf) + 1);
    strcpy(sg->name,buf);
    sg->st_ino = s.st_ino;
    sg->st_dev = s.st_dev;
    sg->fd = fd;
    sg->next = NULL;
    lastLogFileStat->next = sg;
    lastLogFileStat = sg;
  }
  return lastLogFileStat;
}
/*
  
  Source functions

*/

#if __STDC__
void sgSource(char *source)
#else
void sgSource(source)
     char *source;
#endif
{
  struct Source *sp;
  if(Source != NULL){
    if((struct Source *) sgSourceFindName(source) != NULL)
      sgLogFatalError("%s: source %s is defined in configfile %s",
		      progname,source, configFile);
  }
  sp = (struct Source *)sgCalloc(1,sizeof(struct Source));
  sp->ip=NULL;
  sp->userDb=NULL;
  sp->domainDb=NULL;
  sp->active = 1;
  sp->within = 0;
  sp->cont_search = 0;
  sp->time = NULL;
  sp->userquota.seconds = 0;
  sp->userquota.renew = 0;
  sp->userquota.sporadic = 0;
  sp->next=NULL;
  sp->logfile = NULL;
  sp->name = (char  *) sgCalloc(1,strlen(source) + 1);
  strcpy(sp->name,source);

  if(Source == NULL){
    Source = sp;
    lastSource = sp;
  } else {
    lastSource->next = sp;
    lastSource = sp;
  }
}

void sgSourceEnd()
{
 struct Source *s;
 s = lastSource;
 if(s->ip == NULL && s->domainDb == NULL && s->userDb == NULL){
   sgLogError("sourceblock %s missing active content, set inactive",s->name);
   s->time = NULL;
   s->active = 0;
 }
}

#if __STDC__
void sgSourceUser(char *user)
#else
void sgSourceUser(user)
     char *user;
#endif
{
  struct Source *sp;
  char *lc;
  sp = lastSource;
  if(sp->userDb == NULL){
    sp->userDb = (struct sgDb *) sgCalloc(1,sizeof(struct sgDb));
    sp->userDb->type=SGDBTYPE_USERLIST;
    sgDbInit(sp->userDb,NULL);
  }
  for(lc=user; *lc != '\0'; lc++) /* convert username to lowercase chars */
    *lc = tolower(*lc);
  sgDbUpdate(sp->userDb, user, (char *) setuserquota(),
	     sizeof(struct UserQuotaInfo));
}

#if __STDC__
void sgSourceUserList(char *file)
#else
void sgSourceUserList(file)
     char *file;
#endif
{
  char *dbhome = NULL, *f;
  FILE *fd;
  char line[MAX_BUF];
  char *p,*c,*s,*lc;
  int l=0;
  struct Source *sp;
  sp = lastSource;
  if(sp->userDb == NULL){
    sp->userDb = (struct sgDb *) sgCalloc(1,sizeof(struct sgDb));
    sp->userDb->type=SGDBTYPE_USERLIST;
    sgDbInit(sp->userDb,NULL);
  }
  dbhome = sgSettingGetValue("dbhome");
  if(dbhome == NULL)
    dbhome = DEFAULT_DBHOME;
  if (file[0] == '/') {
    f = strdup(file);
  } else {
    f = (char  *) sgCalloc(1,strlen(dbhome) + strlen(file) + 5);
    strcpy(f,dbhome);
    strcat(f,"/");
    strcat(f,file);
  }
  if((fd = fopen(f,"r")) == NULL){
    sgLogError("%s: can't open userlist %s: %s",progname, f,strerror(errno));
    return;
  }
  while(fgets(line,sizeof(line),fd) != NULL){
    l++;
    if(*line == '#')
      continue;
    p = strchr(line,'\n');
    if(p != NULL && p != line){
      if(*(p - 1) == '\r') /* removing ^M  */
	p--;
      *p = '\0';
    }
    c = strchr(line,'#');
    p = strtok(line," \t,");
    if((s = strchr(line,':')) != NULL){
      *s = '\0';
      for(lc=line; *lc != '\0'; lc++) /* convert username to lowercase chars */
	*lc = tolower(*lc);
      sgDbUpdate(sp->userDb, line, (char *) setuserquota(),
		 sizeof(struct UserQuotaInfo));
    } else {
      do {
	if(c != NULL && p >= c) /*find the comment */
	  break;
	for(lc=p; *lc != '\0'; lc++) /* convert username to lowercase chars */
	  *lc = tolower(*lc);
	sgDbUpdate(sp->userDb, p, (char *) setuserquota(),
		   sizeof(struct UserQuotaInfo));
      } while((p=strtok(NULL," \t,")) != NULL);
    }
  }
  fclose(fd);
}

#if __STDC__
void sgSourceUserQuota(char *seconds, char *sporadic, char *renew)
#else
void sgSourceUserQuota(seconds, sporadic, renew)
     char *file;
     char *sporadic;
     char *renew;
#endif
{
  int s;
  struct UserQuota *uq;
  struct Source *sp;
  sp = lastSource;
  uq = &sp->userquota;
  s = atoi(seconds);
  if(s <= 0)
    sgLogError("Userquota seconds sporadic hourly|daily|weekly");
  uq->seconds = s; 
  s = atoi(sporadic);
  if(s <= 0)
    sgLogError("Userquota seconds sporadic hourly|daily|weekly");
  uq->sporadic = s; 
  s = atoi(renew);
  if(s <= 0)
    sgLogError("Userquota seconds sporadic hourly|daily|weekly");
  uq->renew = s;
}


#if __STDC__
void sgSourceDomain(char *domain)
#else
void sgSourceDomain(domain)
     char *domain;
#endif
{
  struct Source *sp;
  sp = lastSource;
  if(sp->domainDb == NULL){
    sp->domainDb = (struct sgDb *) sgCalloc(1,sizeof(struct sgDb));
    sp->domainDb->type=SGDBTYPE_DOMAINLIST;
    sgDbInit(sp->domainDb,NULL);
  }
  sgDbUpdate(sp->domainDb,domain, NULL, 0);
}

#if __STDC__
void sgSourceTime(char *name, int within)
#else
void sgSourceTime(name, within)
     char *name;
     int within;
#endif
{
  struct Time *time = NULL;
  struct Source *sp;
  sp = lastSource;
  if((time = sgTimeFindName(name)) == NULL){
    sgLogFatalError("%s: Time %s is not defined in configfile %s",
		    progname,name, configFile);
  }
  sp->within = within;
  sp->time = time;
}

#if __STDC__
struct Source *sgSourceFindName(char *name)
#else
struct Source *sgSourceFindName(name)
     char *name;
#endif
{
  struct Source *p;
  for(p=Source; p != NULL; p = p->next){
    if(!strcmp(name,p->name))
      return p;
  }
  return NULL;
}

#if __STDC__
void sgSourceIpList(char *file)
#else
void sgSourceIpList(file)
     char *file;
#endif
{
  char *dbhome = NULL, *f;
  FILE *fd;
  char line[MAX_BUF];
  char *p,*c,*cidr;
  int i,l=0;
  dbhome = sgSettingGetValue("dbhome");
  if(dbhome == NULL)
    dbhome = DEFAULT_DBHOME;
  if (file[0] == '/') {
    f = strdup(file);
  } else {
    f = (char  *) sgCalloc(1,strlen(dbhome) + strlen(file) + 5);
    strcpy(f,dbhome);
    strcat(f,"/");
    strcat(f,file);
  }
  if((fd = fopen(f,"r")) == NULL){
    sgLogError("%s: can't open iplist %s: %s",progname, f,strerror(errno));
    return;
  }
  sgLogError("init iplist %s",f);
  while(fgets(line,sizeof(line),fd) != NULL){
    l++;
    if(*line == '#')
      continue;
    p = strchr(line,'\n');
    if(p != NULL && p != line){
      if(*(p - 1) == '\r') /* removing ^M  */
	p--;
      *p = '\0';
    }
    c = strchr(line,'#');
    p = strtok(line," \t,");
    do {
      if(c != NULL && p >= c) /*find the comment */
	break;
      i=strspn(p,".0123456789/-");
      if(i == 0)
	break;
      *(p + i ) = '\0';
      if((cidr = strchr(p,'/')) != NULL){
	*cidr = '\0';
	cidr++;
	sgIp(p);
	sgIp(cidr);
	if(strchr(cidr,'.') == NULL)
	  sgSetIpType(SG_IPTYPE_CIDR,f,l);
	else 
	  sgSetIpType(SG_IPTYPE_CLASS,f,l);
      } else if((cidr = strchr(p,'-')) != NULL) {
	*cidr = '\0';
	cidr++;
	sgIp(p);
	sgIp(cidr);
	sgSetIpType(SG_IPTYPE_RANGE,f,l);
      } else {
	sgIp(p);
	sgIp(strdup("255.255.255.255"));
	sgSetIpType(SG_IPTYPE_HOST,f,l);
      }
    } while((p=strtok(NULL," \t,")) != NULL);
  }
  fclose(fd);
}

/*
  

 */

#if __STDC__
struct Source *sgFindSource (struct Source *bsrc, 
			     char *net, char *ident, char *domain)
#else
struct Source *sgFindSource (bsrc, net, ident, domain)
     struct Source *bsrc;
     char *net;
     char *ident;
     char *domain;
#endif
{
  struct Source *s;
  struct Ip *ip;
  int foundip, founduser, founddomain, unblockeduser;
  unsigned long i, octet = 0, *op;
  struct UserQuotaInfo *userquota;
  if(net != NULL){
    op = sgConvDot(net);
    if(op != NULL)
      octet = *op;
  }
  for(s=bsrc; s != NULL; s = s->next){
    foundip = founduser = founddomain = 0;
    unblockeduser = 1;
    if(s->active == 0)
      continue;
    if(s->ip != NULL){
      if(net == NULL)
	foundip = 0;
      else {
	for(ip=s->ip; ip != NULL; ip = ip->next){
	  if(ip->net_is_set == 0)
	    continue;
	  if(ip->type == SG_IPTYPE_RANGE){
	    if(octet >= ip->net && octet <= ip->mask){
	      foundip = 1;
	      break;
	    }
	  } else { /* CIDR or HOST */
	    i = octet & ip->mask;
	    if(i == ip->net){
	      foundip = 1;
	      break;
	    }
	  }
	}
      }
    } else
      foundip = 1;
    if(s->userDb != NULL){
      if(*ident == '\0')
	founduser = 0;
      else 
	if(defined(s->userDb, ident, (char **) &userquota) == 1){
	  founduser = 1;
	  unblockeduser = 1;
	  if(s->userquota.seconds != 0){
	    struct UserQuotaInfo uq;
	    time_t t = time(NULL) + globalDebugTimeDelta;
	    //sgLogError("status %d time %d lasttime %d consumed %d", userquota->status, userquota->time, userquota->last, userquota->consumed);
	    //sgLogError("renew %d seconds %d", s->userquota.renew, s->userquota.seconds);
	    if(userquota->status == 0){ //first time
	      userquota->status = 1;
	      userquota->time = t;
	      userquota->last = t;
	      //sgLogError("user %s first time %d", ident, userquota->time);
	    } else if(userquota->status == 1){
	      //sgLogError("user %s other time %d %d",ident,userquota->time,t);
	      if(s->userquota.sporadic > 0){
		if(t - userquota->last  < s->userquota.sporadic){
		  userquota->consumed += t - userquota->last;
		  userquota->time = t;
		}
		if(userquota->consumed > s->userquota.seconds){
		  userquota->status = 2; // block this user, time is up
		  unblockeduser = 0;
		}
		userquota->last = t;
		//sgLogError("user %s consumed %d %d",ident,userquota->consumed, userquota->last);
	      } else if(userquota->time + s->userquota.seconds < t){
		sgLogError("time is up user %s blocket", ident);
		userquota->status = 2; // block this user, time is up
		unblockeduser = 0;
	      } 
	    } else {
	      //sgLogError("user %s blocket %d %d %d %d", ident, userquota->status, userquota->time, t, (userquota->time + s->userquota.renew) - t);
	      if(userquota->time + s->userquota.renew < t){ // new chance
		//sgLogError("user %s new chance", ident);
		unblockeduser = 1;
		userquota->status = 1;
		userquota->time = t;
		userquota->consumed = 0;
	      } else 
		unblockeduser = 0;
	    }
	    sgDbUpdate(s->userDb, ident, (void *) userquota, 
		       sizeof(struct UserQuotaInfo));
	  }
	}
    } else
      founduser = 1;
    if(s->domainDb != NULL){
      if(*domain == '\0')
	founddomain = 0;
      else {
	if(defined(s->domainDb, domain, (char **) NULL) == 1)
	  founddomain = 1;
      }
    } else
      founddomain = 1;
    if(founduser && foundip && founddomain){
      if(unblockeduser)
	return s;
      else {
	lastActiveSource = s;
	return NULL;
      }
    }
  }
  return NULL;
}



/*destination block funtions */

#if __STDC__
void sgDest(char *dest)
#else
void sgDest(dest)
     char *dest;
#endif
{
  struct Destination *sp;
  if(Dest != NULL){
    if((struct Destination *) sgDestFindName(dest) != NULL)
      sgLogFatalError("%s: destination %s is defined in configfile %s",
		   progname,dest, configFile);
  }
  sp = (struct Destination *) sgCalloc(1,sizeof(struct Destination));
  sp->domainlist=NULL;
  sp->urllist=NULL;
  sp->expressionlist=NULL;
  sp->redirect=NULL;
  sp->rewrite=NULL;
  sp->active = 1;
  sp->time = NULL;
  sp->within = 0;
  sp->logfile = NULL;
  sp->next=NULL;
  sp->name = (char  *) sgCalloc(1,strlen(dest) + 1);
  strcpy(sp->name,dest);

  if(Dest == NULL){
    Dest = sp;
    lastDest = sp;
  } else {
    lastDest->next = sp;
    lastDest = sp;
  }
}

void sgDestEnd()
{
 struct Destination *d;
 d = lastDest;
 if(d->domainlist == NULL && d->urllist == NULL && d->expressionlist == NULL
    && d->redirect == NULL && d->rewrite == NULL){
   sgLogError("destblock %s missing active content, set inactive",d->name);
   d->time = NULL;
   d->active = 0;
 }
}

#if __STDC__
void sgDestDomainList(char *domainlist)
#else
void sgDestDomainList(domainlist)
     char *domainlist;
#endif
{
  struct Destination *sp;
  char *dbhome = NULL, *dl = domainlist, *name;
  dbhome = sgSettingGetValue("dbhome");
  sp = lastDest;
  if(dbhome == NULL)
    dbhome = DEFAULT_DBHOME;
 if(domainlist == NULL){
    name = sp->name;
    dl = (char *) sgCalloc(1,strlen("/dest/") + strlen(name) + strlen("/domainlist"));
    strcpy(dl,"/dest/");
    strcat(dl,name);
    strcat(dl,"/domainlist");
    sp->domainlist = (char  *) sgCalloc(1,strlen(dbhome) + strlen("/") + strlen(dl) + 4);
    strcpy(sp->domainlist,dbhome);
    strcat(sp->domainlist,"/");
    strcat(sp->domainlist,dl);
  } else {
    if (domainlist[0] == '/') {
      sp->domainlist = strdup(domainlist);
    } else {
    sp->domainlist = (char  *) sgCalloc(1,strlen(dbhome) + strlen("/") + strlen(domainlist) + 4);
    strcpy(sp->domainlist,dbhome);
    strcat(sp->domainlist,"/");
    strcat(sp->domainlist,domainlist);
    }
  }
  sp->domainlistDb = (struct sgDb *) sgCalloc(1,sizeof(struct sgDb));
  sp->domainlistDb->type=SGDBTYPE_DOMAINLIST;
  sgLogError("init domainlist %s",sp->domainlist);
  sgDbInit(sp->domainlistDb,sp->domainlist);
  if(sp->domainlistDb->entries == 0) { /* empty database */
    sgLogError("domainlist empty, removed from memory");
    sgFree(sp->domainlistDb);
    sp->domainlistDb = NULL;
  }
}

#if __STDC__
void sgDestUrlList(char *urllist)
#else
void sgDestUrlList(urllist)
     char *urllist;
#endif
{
  struct Destination *sp;
  char *dbhome = NULL, *dl = urllist, *name;
  dbhome = sgSettingGetValue("dbhome");
  sp = lastDest;
  if(dbhome == NULL)
    dbhome = DEFAULT_DBHOME;
  if(urllist == NULL){
    name = sp->name;
    dl = (char *) sgCalloc(1,strlen("/dest/") + strlen(name) + strlen("/urllist"));
    strcpy(dl,"/dest/");
    strcat(dl,name);
    strcat(dl,"/urllist");
    sp->urllist = (char  *) sgCalloc(1,strlen(dbhome) + strlen("/") + strlen(dl) + 4);
    strcpy(sp->urllist,dbhome);
    strcat(sp->urllist,"/");
    strcat(sp->urllist,dl);
  } else {
    if (urllist[0] == '/') {
      sp->urllist = strdup(urllist);
    } else {
    sp->urllist = (char  *) sgCalloc(1,strlen(dbhome) + strlen("/") + strlen(urllist) + 4);
    strcpy(sp->urllist,dbhome);
    strcat(sp->urllist,"/");
    strcat(sp->urllist,urllist);
    }
  }
  sp->urllistDb = (struct sgDb *) sgCalloc(1,sizeof(struct sgDb));
  sp->urllistDb->type=SGDBTYPE_URLLIST;
  sgLogError("init urllist %s",sp->urllist);
  sgDbInit(sp->urllistDb,sp->urllist);
  if(sp->urllistDb->entries == 0) { /* empty database */
    sgLogError("urllist empty, removed from memory");
    sgFree(sp->urllistDb);
    sp->urllistDb = NULL;
  }
}

#if __STDC__
void sgDestExpressionList(char *exprlist, char *chcase)
#else
void sgDestExpressionList(exprlist, chcase)
     char *exprlist;
     char *chcase;
#endif
{
  FILE *fp;
  char buf[MAX_BUF],errbuf[256];
  struct Destination *sp;
  struct sgRegExp *regexp;
  char *dbhome = NULL, *dl = exprlist, *name, *p;
  int flags = REG_EXTENDED;
  dbhome = sgSettingGetValue("dbhome");
  sp = lastDest;
  if(dbhome == NULL)
    dbhome = DEFAULT_DBHOME;
  if(exprlist == NULL){
    name = sp->name;
    dl = (char *) sgCalloc(1,strlen("/dest/") +strlen(name) + strlen("/expressionlist"));
    strcpy(dl,"/dest/");
    strcat(dl,name);
    strcat(dl,"/expressionlist");
    flags |= REG_ICASE; /* default case insensitive */
    sp->expressionlist = (char  *) sgCalloc(1,strlen(dbhome)+strlen(dl)+10);
    strcpy(sp->expressionlist,dbhome);
    strcat(sp->expressionlist,"/");
    strcat(sp->expressionlist,dl);
  } else {
    if (exprlist[0] == '/') {
      sp->expressionlist = strdup(exprlist);
    } else {
    sp->expressionlist = (char  *) sgCalloc(1,strlen(dbhome) + strlen("/") + strlen(exprlist) + 4);
    strcpy(sp->expressionlist,dbhome);
    strcat(sp->expressionlist,"/");
    strcat(sp->expressionlist,exprlist);
    }
    if(strncmp(chcase,"c",1))
          flags |= REG_ICASE; /* set case insensitive */
  }
  sgLogError("init expressionlist %s",sp->expressionlist);
  if ((fp = fopen(sp->expressionlist, "r")) == NULL) 
    sgLogFatalError("%s: %s", sp->expressionlist, strerror(errno));
  while(fgets(buf, sizeof(buf), fp) != NULL){
    p = (char *) strchr(buf,'\n');
    if(p != NULL && p != buf){
      if(*(p - 1) == '\r') /* removing ^M  */
	p--;
      *p = '\0';
    }
    regexp=sgNewPatternBuffer(buf,flags);
    if(regexp->error){
      regerror(regexp->error,regexp->compiled, errbuf,sizeof(errbuf));
      sgLogError("%s: %s", sp->expressionlist, strerror(errno));
    }
    if(lastDest->regExp == NULL){
      lastDest->regExp = regexp;
      lastRegExpDest = regexp;
    } else {
      lastRegExpDest->next = regexp;
      lastRegExpDest = regexp;
    }
  }
  fclose(fp);
}

#if __STDC__
void sgDestRedirect(char *value)
#else
void sgDestRedirect(value)
     char *value;
#endif
{
  struct Destination *sp;
  sp = lastDest;
  sp->redirect = (char *) sgCalloc(1,strlen(value) + 1);
  strcpy(sp->redirect,value);
}

void sgDestRewrite(char *value){
  struct sgRewrite *rewrite = NULL;
  struct Destination *sp;
  sp = lastDest;
  if((rewrite = sgRewriteFindName(value)) == NULL){
    sgLogFatalError("%s: Rewrite %s is not defined in configfile %s",
		    progname,value, configFile);
  }
  sp->rewrite = rewrite;
}

#if __STDC__
int sgRegExpMatch(struct sgRegExp *regexp, char *str)
#else
int sgRegExpMatch(regexp, str)
     struct sgRegExp *regexp;
     char *str;
#endif
{
  struct sgRegExp *rp;
  static char errbuf[256];
  int error;
  for(rp = regexp; rp != NULL; rp = rp->next){
    error = regexec(rp->compiled, str, 0,0,0);
    if(error != 0 && error != REG_NOMATCH) {
      regerror(error,rp->compiled, errbuf,sizeof(errbuf));
      sgLogError("Error in regex %30.30s %-60.60s  %d %s\n",rp->pattern,str,error,errbuf);
    }
    if(error == 0) /* match */
      return 1;
  }
  return 0;
}

#if __STDC__
void sgDestTime(char *name, int within)
#else
void sgDestTime(name, within)
     char *name;
     int within;
#endif
{
  struct Time *time = NULL;
  struct Destination *sp;
  sp = lastDest;
  if((time = sgTimeFindName(name)) == NULL){
    sgLogFatalError("%s: Time %s is not defined in configfile %s",
		    progname,name, configFile);
  }
  sp->within = within;
  sp->time = time;
}

#if __STDC__
struct Destination *sgDestFindName(char *name)
#else
struct Destination *sgDestFindName(name)
     char *name;
#endif
{
  struct Destination *p;
  for(p=Dest; p != NULL; p = p->next){
    if(!strcmp(name,p->name))
      return p;
  }
  return NULL;
}

/*
  Setting functions
*/


#if __STDC__
void sgSetting(char *name, char *value)
#else
void sgSetting(name, value)
     char *name;
     char *value;
#endif
{
  struct Setting *sp;
  if(Setting != NULL){
    if((struct Setting *) sgSettingFindName(name) != NULL)
      sgLogFatalError("%s: setting %s is defined in configfile %s",
		      progname,name, configFile);
  }
  sp = (struct Setting *) sgCalloc(1,sizeof(struct Setting));

  sp->name = strdup(name);
  sp->value = strdup(value);

  if(Setting == NULL){
    Setting = sp;
    lastSetting = sp;
  } else {
    lastSetting->next = sp;
    lastSetting = sp;
  }
  if(!strcmp(name,"logdir")){
    globalLogDir= strdup(value);
  }
}

#if __STDC__
struct Setting *sgSettingFindName(char *name)
#else
struct Setting *sgSettingFindName(name)
     char *name;
#endif
{
  struct Setting *p;
  for(p=Setting; p != NULL; p = p->next){
    if(!strcmp(name,p->name))
      return p;
  }
  return NULL;
}


#if __STDC__
char *sgSettingGetValue(char *name)
#else
char *sgSettingGetValue(name)
     char *name;
#endif
{
  struct Setting *p;
  p = sgSettingFindName(name);
  if(p != NULL)
    return p->value;
  return NULL;
}


/*
  
  sgRewrite function

 */

#if __STDC__
void sgRewrite(char *rewrite)
#else
void sgRewrite(rewrite)
     char *rewrite;
#endif
{
  struct sgRewrite *rew;
  if(Rewrite != NULL){
    if((struct sgRewrite *) sgRewriteFindName(rewrite) != NULL)
      sgLogFatalError("%s: rewrite %s is defined in configfile %s",
		      progname,rewrite, configFile);
  }
  rew = (struct sgRewrite *) sgCalloc(1,sizeof(struct sgRewrite));
  rew->name = strdup(rewrite);
  rew ->rewrite = NULL;
  rew->logfile = NULL;
  rew->time = NULL;
  rew->active = 1;
  rew->within = 0;
  rew->next=NULL;

  if(Rewrite == NULL){
    Rewrite = rew;
    lastRewrite = rew;
  } else {
    lastRewrite->next = rew;
    lastRewrite = rew;
  }
}

#if __STDC__
void sgRewriteTime(char *name, int within)
#else
void sgRewriteTime(name, within)
     char *name;
     int within;
#endif
{
  struct Time *time = NULL;
  struct sgRewrite *sp;
  sp = lastRewrite;
  if((time = sgTimeFindName(name)) == NULL){
    sgLogFatalError("%s: Time %s is not defined in configfile %s",
		    progname,name, configFile);
  }
  sp->within = within;
  sp->time = time;
}

#if __STDC__
void sgRewriteSubstitute (char *string)
#else
void sgRewriteSubstitute (string)
     char *string;
#endif
{
  char *pattern, *subst = NULL , *p;
  int flags = REG_EXTENDED ;
  int global = 0;
  char *httpcode = NULL;
  struct sgRegExp *regexp;
  char errbuf[256];
  pattern = string + 2 ; /* skipping s@ */
  p = pattern;
  while((p = strchr(p,'@')) != NULL){
    if(*( p - 1) != '\\'){
      *p = '\0';
      subst = p + 1;
      break;
    }
    p++;
  }
  p= strrchr(subst,'@');
  while(p != NULL && *p != '\0'){
    if(*p == 'r' )
      httpcode =  REDIRECT_TEMPORARILY;
    if(*p == 'R' )
      httpcode =  REDIRECT_PERMANENT;
    if(*p == 'i' || *p == 'I')
      flags |= REG_ICASE;
    if(*p == 'g')
      global = 1;
    *p = '\0'; /*removes @i from string */
    p++;
  } 
  regexp=sgNewPatternBuffer(pattern,flags);
  if(regexp->error){
      regerror(regexp->error,regexp->compiled, errbuf,sizeof(errbuf));
      sgLogError("Error in regexp %s: %s",pattern,errbuf);
  } else {
    regexp->substitute = strdup(subst);
  }
  if(lastRewrite->rewrite == NULL)
    lastRewrite->rewrite = regexp;
  else 
    lastRewriteRegExec->next=regexp;
  regexp->httpcode = httpcode;
  regexp->global = global;
  lastRewriteRegExec = regexp;
}

#if __STDC__
char *sgRewriteExpression(struct sgRewrite *rewrite, char *subst)
#else
char *sgRewriteExpression(rewrite, subst)
     struct sgRewrite *rewrite;
     char *subst;
#endif
{
  char *result = NULL;
  result = sgRegExpSubst(rewrite->rewrite, subst);
  return result;
}

#if __STDC__
struct sgRewrite *sgRewriteFindName(char *name)
#else
struct sgRewrite *sgRewriteFindName(name)
     char *name;
#endif
{
  struct sgRewrite *p;
  for(p=Rewrite; p != NULL; p = p->next){
    if(!strcmp(name,p->name))
      return p;
  }
  return NULL;
}



/*
  Time functions
*/

#if __STDC__
void sgTime(char *name)
#else
void sgTime(name)
     char *name;
#endif
{
  struct Time *t;
  if(Time != NULL){
    if((struct Time *) sgTimeFindName(name) != NULL)
      sgLogFatalError("%s: time %s is defined in configfile %s",
		      progname,name, configFile);
  } else 
    numTimeElements = 0;
  t = (struct Time *) sgCalloc(1,sizeof(struct Time));
  t->name = strdup(name);
  t->element = NULL;
  t->active = 1;
  TimeElement = NULL;
  lastTimeElement = NULL;
  if(Time == NULL){
    Time = t;
    lastTime = t;
  } else {
    lastTime->next = t;
    lastTime = t;
  }
}

#if __STDC__
void sgTimeElementInit()
#else
void sgTimeElementInit()
#endif
{
  struct TimeElement *te;
  te = (struct TimeElement *) sgCalloc(1,sizeof(struct TimeElement));
  numTimeElements++;
  if(lastTime->element == NULL)
    lastTime->element = te;
  if(lastTimeElement != NULL)
    lastTimeElement->next = te;
  lastTimeElement = te;
}

#if __STDC__
void sgTimeElementEnd ()
#else
void sgTimeElementEnd ()
#endif
{
  time_switch = 0;
  date_switch = 0;
  if(lastTimeElement->fromdate !=0){
    if(lastTimeElement->todate == 0)
      lastTimeElement->todate = lastTimeElement->fromdate + 86399;
    else 
      lastTimeElement->todate = lastTimeElement->todate + 86399;
  }
  if(lastTimeElement->from == 0 && lastTimeElement->to == 0)
    lastTimeElement->to = 1439; /* set time to 23:59 */
}

#if __STDC__
void sgTimeElementAdd (char *element, char type) 
#else
void sgTimeElementAdd (element, type) 
     char *element;
     char type;
#endif
{
  struct TimeElement *te;
  char *p;
  char wday = 0;
  int h,m,Y,M = 0,D = -1;
  time_t sec;
  te = lastTimeElement;
  switch(type) {
  case T_WEEKDAY:
    p = strtok(element," \t,");
    do {
      if(*p == '*'){
	wday = 127;
      } else if(!strncmp(p,"sun",3)){
	wday = wday | 0x01;
      } else if(!strncmp(p,"mon",3)){
	wday = wday | 0x02;
      } else if(!strncmp(p,"tue",3)){
	wday = wday | 0x04;
      } else if(!strncmp(p,"wed",3)){
	wday = wday | 0x08;
      } else if(!strncmp(p,"thu",3)){
	wday = wday | 0x10;
      } else if(!strncmp(p,"fri",3)){
	wday = wday | 0x20;
      } else if(!strncmp(p,"sat",3)){
	wday = wday | 0x40;
      }
      p=strtok(NULL," \t,");
    } while(p != NULL);
    te->wday = wday;
    break;
  case T_TVAL:
    sscanf(element,"%d:%d",&h,&m);
    if((h < 0 && h > 24) && (m < 0 && m > 59))
      sgLogFatalError("%s: time formaterror in %s line %d",
		      progname, configFile,lineno);
    if(time_switch == 0){
      time_switch++;
      te->from = (h * 60) + m ;
    } else {
      time_switch=0;
      te->to = (h * 60) + m ;
    }
    break;
  case T_DVAL:
    sec = date2sec(element);
    if(sec == -1){
      sgLogFatalError("%s: date formaterror in %s line %d",
		      progname, configFile,lineno);
    }
    if(date_switch == 0){
      date_switch++;
      te->fromdate = sec;
    } else {
      date_switch=0;
      te->todate = sec;
    }
    break;
  case T_DVALCRON:
    p = strtok(element,"-.");
    Y = atoi(p);
    if(*p == '*')
      Y = -1;
    else
      Y = atoi(p);
    while((p=strtok(NULL,"-.")) != NULL){
      if(*p == '*')
	if(M == 0)
	  M = -1;
	else 
	  D = -1;
      else
	if(M == 0)
	  M = atoi(p);
	else
	  D = atoi(p);
    }
    te->y=Y; te->m=M; te->d=D;
    break;
  case T_WEEKLY:
    p = element;
    while(*p != '\0'){
      switch(*p){
      case 'S':
      case 's':
	wday = wday | 0x01;
	break;
      case 'M':
      case 'm':
	wday = wday | 0x02;
	break;
      case 'T':
      case 't':
	wday = wday | 0x04;
	break;
      case 'W':
      case 'w':
	wday = wday | 0x08;
	break;
      case 'H':
      case 'h':
	wday = wday | 0x10;
	break;
      case 'F':
      case 'f':
	wday = wday | 0x20;
	break;
      case 'A':
      case 'a':
	wday = wday | 0x40;
	break;
      default:
	sgLogFatalError("%s: weekday formaterror in %s line %d",
			progname, configFile,lineno);
	break;
      }
      p++;
    }
    te->wday = wday;
    break;
  }
}


#if __STDC__
struct Time *sgTimeFindName(char *name)
#else
struct Time *sgTimeFindName(name)
     char *name;
#endif
{
  struct Time *p;
  for(p=Time; p != NULL; p = p->next){
    if(!strcmp(name,p->name))
      return p;
  }
  return NULL;
}

#if __STDC__
int sgTimeCmp(const int *a, const int *b)
#else
int sgTimeCmp(a, b)
     const int *a;
     const int *b;
#endif
{
  return *a - *b;
}

#if __STDC__
void sgTimeElementSortEvents()
#else
void sgTimeElementSortEvents()
#endif
{
 struct Time *p;
 struct TimeElement *te;
 int i = 0,j;
 int *t;
 if(Time != NULL){
   TimeElementsEvents = (int *) sgCalloc(numTimeElements * 2 , sizeof(int)); 
   t = (int *) sgCalloc(numTimeElements * 2, sizeof(int)); 
   for(p = Time; p != NULL; p = p->next){
     for(te = p->element; te != NULL; te = te->next){
       TimeElementsEvents[i++]= te->from == 0 ? 1440 : te->from;
       TimeElementsEvents[i++]= te->to == 0 ? 1440 : te->to;
     }
   }
   qsort(TimeElementsEvents,numTimeElements * 2,sizeof(int),
	 (void *) &sgTimeCmp);
   for(i=0,j=0; i < numTimeElements * 2; i++){
     if(j==0){
       t[j++] = TimeElementsEvents[i];
     } else {
       if(t[j-1] != TimeElementsEvents[i]){
	 t[j++]=TimeElementsEvents[i];
       }
     }
   }
   sgFree(TimeElementsEvents);
   numTimeElements = j;
   TimeElementsEvents = t;
 }
}

#if __STDC__
int sgTimeNextEvent()
#else
int sgTimeNextEvent()
#endif
{
  time_t t;
  struct tm *lt;
  int m = 0; 
  static int lastval= 0;
  static int index = 0;
#if HAVE_SIGACTION
  struct sigaction act;
#endif
  if(Time == NULL)
    return 0;
  t = time(NULL) + globalDebugTimeDelta;

  lt = localtime(&t); 
  m = (lt->tm_hour * 60) + lt->tm_min ;
  
  for(index=0; index < numTimeElements; index++){
    if(TimeElementsEvents[index] >= m){
      break;
    }
  }
  lastval = TimeElementsEvents[index];
#if HAVE_SIGACTION
#ifndef SA_NODEFER
#define SA_NODEFER 0
#endif
  act.sa_handler = sgAlarm;
  act.sa_flags = SA_NODEFER | SA_RESTART;
  sigaction(SIGALRM, &act, NULL);
#else
#if HAVE_SIGNAL
  signal(SIGALRM, &sgAlarm);
#else
#endif
#endif
  if(lastval < m )
    m = (((1440 - m ) + lastval) * 60) - lt->tm_sec;
  else
    m = ((lastval - m) * 60) - lt->tm_sec;
  if(m <= 0)
    m = 30;
  sgLogError("recalculating alarm in %d seconds", (unsigned int)m);
  alarm((unsigned int) m);
  sgTimeCheck(lt,t);
  sgTimeSetAcl();
  return 0;
}

#if __STDC__
int sgTimeCheck(struct tm *lt, time_t t)
#else
int sgTimeCheck(lt, t)
     struct tm *lt;
     time_t t;
#endif
{
  struct Time *sg;
  struct TimeElement *te;
  int min;
  if(Time == NULL)
    return -1;
  for(sg = Time; sg != NULL; sg = sg->next){
    sg->active = 0;
    for(te = sg->element; te != NULL ; te = te->next){
      if(te->wday != 0){
	if(((1 << lt->tm_wday ) & te->wday) != 0) {
	  min = (lt->tm_hour * 60 ) + lt->tm_min;
	  if(min >= te->from && min < te->to){
	    sg->active = 1;
	    break;
	  }
	}
      } else { /* date */
	if(te->fromdate != 0){
	  if(t >= te->fromdate && t <= te->todate){
	    min = (lt->tm_hour * 60 ) + lt->tm_min;
	    if(min >= te->from && min < te->to){
	      sg->active =1;
	      break;
	    }
	  }
	} else { /* cron */
	  if(te->y == -1 || te->y == (lt->tm_year + 1900)){
	    if(te->m == -1 || te->m == (lt->tm_mon + 1)){
	      if(te->d == -1 || te->d == (lt->tm_mday)){
		min = (lt->tm_hour * 60 ) + lt->tm_min;
		if(min >= te->from && min < te->to){
		  sg->active =1;
		  break;
		}
	      }
	    }
	  }
	}
      }
    }
  }
  return 0;
}

void sgTimeSetAcl()
{
  struct Acl *acl = defaultAcl;
  struct Destination *d;
  struct Source *s;
  struct sgRewrite *rew;
  for(acl=Acl; acl != NULL; acl = acl->next){
    if(acl->time != NULL){
      acl->active = acl->time->active;
      if(acl->within == OUTSIDE)
	if(acl->active)
	  acl->active = 0;
	else
	  acl->active = 1;
      if(acl->next != NULL && acl->next->within == ELSE){
	if(acl->active == 0){
	  acl->next->active = 1;
	} else {
	  acl->next->active = 0;
	}
      }
    }
  }
  for(d = Dest; d != NULL; d = d->next){
    if(d->time != NULL){
      d->active = d->time->active;
      if(d->within == OUTSIDE)
	if(d->active)
	  d->active = 0;
	else
	  d->active = 1;
    }
  }
  for(s = Source; s != NULL; s = s->next){
    if(s->time != NULL){
      s->active = s->time->active;
      if(s->within == OUTSIDE)
	if(s->active)
	  s->active = 0;
	else
	  s->active = 1;
    }
  }
  for(rew = Rewrite; rew != NULL; rew = rew->next){
    if(rew->time != NULL){
      rew->active = rew->time->active;
      if(rew->within == OUTSIDE)
	if(rew->active)
	  rew->active = 0;
	else
	  rew->active = 1;
    }
  }
}

void sgTimeElementClone() {
  struct TimeElement *te = lastTimeElement, *tmp;
  if ( lastTimeElement == NULL ) {
    sgLogFatalError("No prev TimeElement in sgTimeElementClone !");
  } else {
    sgTimeElementInit();
    lastTimeElement->wday = te->wday;
    lastTimeElement->from = te->from;
    lastTimeElement->to = te->to;
    lastTimeElement->y = te->y;
    lastTimeElement->m = te->m;
    lastTimeElement->d = te->d;
    lastTimeElement->fromdate = te->fromdate;
    lastTimeElement->todate = te->todate;
    tmp = lastTimeElement;
    lastTimeElement = te;
    sgTimeElementEnd();
    lastTimeElement = tmp;
  }
}

void sgTimePrint() {
  struct Time *t;
  struct TimeElement *te;
  for(t = Time; t != NULL; t = t->next){
    printf("Time %s is ",t->name);
    t->active ? printf("active\n") : printf("inactive\n");
    for(te = t->element; te != NULL; te = te->next){
      printf("\tte->wday     = %x\n",te->wday);
      printf("\tte->from     = %d\n",te->from);
      printf("\tte->to       = %d\n",te->to);
      printf("\tte->y,m,d    = %d-%d-%d\n",te->y,te->m,te->d);
      printf("\tte->fromdate = %s\n",te->fromdate == 0 ?
             "0" : niso(te->fromdate));
      printf("\tte->todate   = %s\n\n",te->todate == 0 ?
             "0" : niso(te->todate));
    }
  }
}


/*
  Ip functions
*/


#if __STDC__
void sgSetIpType(int type, char *file, int line)
#else
void sgSetIpType(type, file, line)
     int type;
     char *file;
     int line;
#endif
{
  struct Ip *ip = sgIpLast(lastSource),*nip;
  char *p;
  char *f = file == NULL ? configFile : file;
  int l = line == 0 ? lineno : line ;
  unsigned long octet, *op = NULL;
  if(type == SG_IPTYPE_HOST)
    ip->mask = 0xffffffff;
  if(type == SG_IPTYPE_RANGE){
    if((op=sgConvDot(ip->str)) == NULL)
      sgLogFatalError("%s: address error in %s line %d", progname, f,l);
    else 
      ip->mask = *op;
    if(ip->net > ip->mask)
      sgLogFatalError("%s: iprange error in %s line %d", progname, f,l);
  }
  if(type == SG_IPTYPE_CLASS){
    p=ip->str;
    if(*p == '/')
      p++;
    if((op=sgConvDot(p)) == NULL)
      sgLogFatalError("%s: address error in %s line %d", progname, f,l);
    else 
      ip->mask = *op;
  }
  if(type == SG_IPTYPE_CIDR){
    p=ip->str;
    if(*p == '/')
      p++;
    octet = atoi(p);
    if(octet < 0 || octet > 32){
      sgLogFatalError("%s: prefix error /%s in %s line %d",
		      progname,p, f,l);
    }
    if(octet == 32)
      ip->mask = 0xffffffff;
    else
      ip->mask = 0xffffffff ^ (0xffffffff >> octet);
    ip->net = ip->net & ip->mask;
  }
  ip->type = type;
  nip = (struct Ip *) sgCalloc(1,sizeof(struct Ip));
  ip->next = nip ;
}

#if __STDC__
void sgIp(char *name)
#else
void sgIp(name)
     char *name;
#endif
{
  struct Ip *ip;
  unsigned long *op;
  if(lastSource->ip == NULL){
    ip = (struct Ip *) sgCalloc(1,sizeof(struct Ip));
    ip->next = NULL;
    lastSource->ip = ip;
    lastSource->lastip = ip;
  } else {
    ip = sgIpLast(lastSource);
  }
  if(ip->net_is_set == 0){
    ip->net_is_set = 1;
    if((op=sgConvDot(name)) == NULL){
      sgLogFatalError("%s: address error in %s line %d", progname, configFile,lineno);
    } else 
      ip->net = *op;
  } else {
    ip->str = (char *) sgCalloc(1,strlen(name) + 1);
    strcpy(ip->str,name);
  }
}

#if __STDC__
struct Ip *sgIpLast(struct Source *s)
#else
struct Ip *sgIpLast(s)
     struct Source *s;
#endif
{
  struct Ip *ip,*ret = NULL ;
  for(ip=s->ip; ip != NULL; ip = ip->next)
    ret = ip;
  return ret;
}

/*
  ACL functions
*/


#if __STDC__
void sgAcl(char *name, char *value, int within)
#else
void sgAcl(name, value, within)
     char *name;
     char *value;
     int within;
#endif
{
  struct Acl *acl;
  struct Source *source = NULL;
  struct Time *time = NULL;
  int def = 0;
  char *s;
  if(name != NULL){
    /* due to some strange things in my yacc code */
    if((s=(char *) strchr(name,' ')) != NULL)
      *s='\0';    
    if((s=(char *) strchr(name,'\t')) != NULL)
      *s='\0';    
    /*
    if(Acl != NULL){
      if((struct Acl *) sgAclFindName(name) != NULL){
	sgLogFatalError("%s: ACL %s is defined in configfile %s",
			progname,name, configFile);
      }
    }
    */
  }
  if(lastAcl != NULL && name == NULL && within == ELSE) 
    name = lastAcl->name;
  acl = (struct Acl *)sgCalloc(1,sizeof(struct Acl));
  if(!strcmp(name,"default")){
    defaultAcl=acl;
    def++;
  } else {
    if((source = sgSourceFindName(name)) == NULL && !def){
      sgLogFatalError("%s: ACL source %s is not defined in configfile %s",
		      progname,name, configFile);
    }
  }
  acl->name = sgCalloc(1,strlen(name) + 1);
  strcpy(acl->name,name);
  acl->active = within == ELSE ? 0 : 1;
  acl->source = source;
  acl->pass = NULL;
  acl->rewriteDefault = 1;
  acl->rewrite = NULL;
  acl->redirect = NULL;
  acl->within = within;
  acl->logfile = NULL;
  acl->next = NULL;
  if(value != NULL){
    if((time = sgTimeFindName(value)) == NULL){
      sgLogFatalError("%s: ACL time %s is not defined in configfile %s",
		      progname,value, configFile);
    }
    acl->time = time;
  }
  if(Acl == NULL){
    Acl = acl;
    lastAcl = acl;
  } else {
    lastAcl->next = acl;
    lastAcl = acl;
  }
}

#if __STDC__
void sgAclSetValue (char *what, char *value, int allowed) 
#else
void sgAclSetValue (what, value, allowed)
     char *what;
     char *value;
     int allowed;
#endif
{
  struct Destination *dest = NULL;
  struct sgRewrite *rewrite = NULL;
  struct AclDest *acldest;
  int type = ACL_TYPE_TERMINATOR;
  if(!strcmp(what,"pass")){
    if(!strcmp(value,"any") || !strcmp(value,"all"))
      allowed = 1;
    else if(!strcmp(value,"none"))
      allowed=0;
    else if(!strcmp(value,"in-addr")){
      type = ACL_TYPE_INADDR;
    } else {
      if((dest = sgDestFindName(value)) == NULL){
	sgLogFatalError("%s: ACL destination %s is not defined in configfile %s",
			progname,value, configFile);
      } 
      type = ACL_TYPE_DEFAULT;
    }

    acldest = sgCalloc(1,sizeof(struct AclDest));
    acldest->name = (char *) sgCalloc(1,strlen(value) + 1);
    strcpy(acldest->name,value);
    acldest->dest = dest;
    acldest->access = allowed;
    acldest->type = type;
    acldest->next = NULL;
    if(lastAcl->pass == NULL){
      lastAcl->pass = acldest;
    } else {
      lastAclDest->next = acldest;
    }
    lastAclDest = acldest;
  }

  if(!strcmp(what,"rewrite")){
    if(!strcmp(value,"none")){
      lastAcl->rewriteDefault = 0;
      lastAcl->rewrite = NULL;
    } else {
      if((rewrite = sgRewriteFindName(value)) == NULL){
	sgLogFatalError("%s: Rewrite %s is not defined in configfile %s",
			progname,value, configFile);
      }
      lastAcl->rewriteDefault = 0;
      lastAcl->rewrite = rewrite;
    }
  }
  if(!strcmp(what,"redirect")){
    if(strcmp(value,"default")){
      lastAcl->redirect = (char *) sgCalloc(1,strlen(value) + 1);
      strcpy(lastAcl->redirect,value);
    } else {
      lastAcl->redirect= NULL;
    }
  }
}

#if __STDC__
struct Acl *sgAclFindName(char *name)
#else
struct Acl *sgAclFindName(name)
     char *name;
#endif
{
  struct Acl *p;
  for(p=Acl; p != NULL; p = p->next){
    if(!strcmp(name,p->name))
      return p;
  }
  return NULL;
}


#if __STDC__
struct Acl *sgAclCheckSource(struct Source *source)
#else
struct Acl *sgAclCheckSource(source)
     struct Source *source;
#endif
{
  struct Acl *acl = defaultAcl;
  int found = 0;
  if(source != NULL){
    for(acl=Acl; acl != NULL; acl = acl->next){
      if(acl->source == source){
	if(acl->active){
	  found++;
	  break;
	} else {
	  if(acl->next->source == source && acl->next->active != 0){
	    found++;
	    acl=acl->next;
	    break;
	  }
	}
      }
    }
  }
  if(!found)
    acl = defaultAcl;
  return acl;
}

#if __STDC__
char *sgAclAccess(struct Source *src, struct Acl *acl, struct SquidInfo *req)
#else
char *sgAclAccess(src, acl, req)
     struct Source *src;
     struct Acl *acl;
     struct SquidInfo *req;
#endif
{
  int access = 1,result;
  char *redirect = NULL, *dbdata = NULL, *p;
  struct sgRewrite *rewrite = NULL;
  struct AclDest *aclpass = NULL;
  if(acl == NULL)
    return NULL;
  if(acl->pass == NULL)
    acl->pass = defaultAcl->pass;
  if(acl->pass != NULL){
    for(aclpass = acl->pass; aclpass != NULL; aclpass = aclpass->next){
      if(aclpass->dest != NULL && !aclpass->dest->active)
	continue;
      if(aclpass->type == ACL_TYPE_TERMINATOR){
	access=aclpass->access;
	break;
      }
      if(aclpass->type == ACL_TYPE_INADDR){
	if(req->dot){
	  access=aclpass->access;
	  break;
	}
	continue;
      }
      if(aclpass->dest->domainlistDb != NULL){
	result = defined(aclpass->dest->domainlistDb, req->domain, &dbdata);
	if(result == DB_NOTFOUND)
	  continue;
	if(result){
	  if(aclpass->access){
	    access++;
	    break; 
	  } else {
	    access = 0;
	    break;
	  }
	}
      }
      if(aclpass->dest->urllistDb != NULL && access){
	result = defined(aclpass->dest->urllistDb,req->strippedurl, &dbdata);
	if(result == DB_NOTFOUND)
	  continue;
	if(result){
	  if(aclpass->access){
	    access++;
	    break;
	  } else {
	    access = 0;
	    break;
	  }
	}
      }
      if(aclpass->dest->regExp != NULL && access){
	if((result = sgRegExpMatch(aclpass->dest->regExp,req->url)) != 0){
	  if(aclpass->access){
	    access++;
	    break;
	  } else {
	    access = 0;
	    break;
	  }
	}
      }
    }
    if(!access){
      if(dbdata != NULL)
	redirect = dbdata;
      else if(aclpass->dest != NULL && aclpass->dest->redirect != NULL)
	redirect = aclpass->dest->redirect;
      else if(aclpass->dest != NULL && aclpass->dest->rewrite != NULL &&
	      (redirect = 
	       sgRewriteExpression(aclpass->dest->rewrite,req->orig)) != NULL){
	;
      }
      else if(acl->redirect == NULL)
	redirect = defaultAcl->redirect;
      else
	redirect = acl->redirect;
    }
  } else {  /* acl->pass == NULL, probably defaultAcl->pass == NULL */
    access=0;
    redirect = defaultAcl->redirect;
  }
  if(acl->rewrite == NULL)
    rewrite = defaultAcl->rewrite;
  else
    rewrite = acl->rewrite;
  if(rewrite != NULL && access){
    if((p = sgRewriteExpression(rewrite,req->orig)) != NULL){
      redirect = p;
      if(rewrite->logfile != NULL){
	globalLogFile = rewrite->logfile;
	sgLogRequest(globalLogFile,req,acl,aclpass,rewrite);
      }
    }
  } else if(redirect != NULL) {
    redirect = sgParseRedirect(redirect, req, acl, aclpass);
    if(src != NULL && src->logfile != NULL)
      globalLogFile = src->logfile;
    if(aclpass == NULL || aclpass->dest == NULL){
      if(defaultAcl->logfile != NULL)
	      globalLogFile = defaultAcl->logfile;
    } else
      if(aclpass->dest->logfile != NULL)
	globalLogFile = aclpass->dest->logfile;
    if(globalLogFile != NULL)
      sgLogRequest(globalLogFile,req,acl,aclpass,NULL);
  }
  return redirect;
}

#if __STDC__
void yyerror(char *s)
#else
void yyerror(s)
     char *s;
#endif
{
  sgLogFatalError("%s in configfile %s line %d",s,configFile,lineno);
}


#if __STDC__
int yywrap()
#else
int yywrap()
#endif
{
  return 1;
}
