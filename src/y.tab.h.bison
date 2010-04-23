/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

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
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     WORD = 258,
     END = 259,
     START_BRACKET = 260,
     STOP_BRACKET = 261,
     WEEKDAY = 262,
     LDAPDNSTR = 263,
     DESTINATION = 264,
     REWRITE = 265,
     ACL = 266,
     TIME = 267,
     TVAL = 268,
     DVAL = 269,
     DVALCRON = 270,
     SOURCE = 271,
     CIDR = 272,
     IPCLASS = 273,
     CONTINUE = 274,
     IPADDR = 275,
     DBHOME = 276,
     DOMAINLIST = 277,
     URLLIST = 278,
     EXPRESSIONLIST = 279,
     IPLIST = 280,
     DOMAIN = 281,
     USER = 282,
     USERLIST = 283,
     USERQUERY = 284,
     LDAPUSERSEARCH = 285,
     USERQUOTA = 286,
     IP = 287,
     NL = 288,
     NUMBER = 289,
     PASS = 290,
     REDIRECT = 291,
     LOGDIR = 292,
     SUBST = 293,
     CHAR = 294,
     MINUTELY = 295,
     HOURLY = 296,
     DAILY = 297,
     WEEKLY = 298,
     DATE = 299,
     WITHIN = 300,
     OUTSIDE = 301,
     ELSE = 302,
     LOGFILE = 303,
     ANONYMOUS = 304,
     VERBOSE = 305,
     CONTINIOUS = 306,
     SPORADIC = 307,
     LDAPCACHETIME = 308,
     EXECUSERLIST = 309,
     EXECCMD = 310,
     LDAPPROTOVER = 311,
     LDAPBINDDN = 312,
     LDAPBINDPASS = 313,
     MYSQLUSERNAME = 314,
     MYSQLPASSWORD = 315,
     DATABASE = 316
   };
#endif
/* Tokens.  */
#define WORD 258
#define END 259
#define START_BRACKET 260
#define STOP_BRACKET 261
#define WEEKDAY 262
#define LDAPDNSTR 263
#define DESTINATION 264
#define REWRITE 265
#define ACL 266
#define TIME 267
#define TVAL 268
#define DVAL 269
#define DVALCRON 270
#define SOURCE 271
#define CIDR 272
#define IPCLASS 273
#define CONTINUE 274
#define IPADDR 275
#define DBHOME 276
#define DOMAINLIST 277
#define URLLIST 278
#define EXPRESSIONLIST 279
#define IPLIST 280
#define DOMAIN 281
#define USER 282
#define USERLIST 283
#define USERQUERY 284
#define LDAPUSERSEARCH 285
#define USERQUOTA 286
#define IP 287
#define NL 288
#define NUMBER 289
#define PASS 290
#define REDIRECT 291
#define LOGDIR 292
#define SUBST 293
#define CHAR 294
#define MINUTELY 295
#define HOURLY 296
#define DAILY 297
#define WEEKLY 298
#define DATE 299
#define WITHIN 300
#define OUTSIDE 301
#define ELSE 302
#define LOGFILE 303
#define ANONYMOUS 304
#define VERBOSE 305
#define CONTINIOUS 306
#define SPORADIC 307
#define LDAPCACHETIME 308
#define EXECUSERLIST 309
#define EXECCMD 310
#define LDAPPROTOVER 311
#define LDAPBINDDN 312
#define LDAPBINDPASS 313
#define MYSQLUSERNAME 314
#define MYSQLPASSWORD 315
#define DATABASE 316




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 80 "sg.y"
{
  char *string;
  char *tval;
  char *dval;
  char *dvalcron;
  int  *integer;
}
/* Line 1489 of yacc.c.  */
#line 179 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

