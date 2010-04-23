/*
  By accepting this notice, you agree to be bound by the following
  agreements:
  
  This software product, squidGuard, is copyrighted (C) 1998 by
  ElTele Øst AS, Oslo, Norway, with all rights reserved.
  
  This program is free software; you can redistribute it and/or modify it
  under the terms of the GNU General Public License (version 2) as
  published by the Free Software Foundation.  It is distributed in the
  hope that it will be useful, but WITHOUT ANY WARRANTY; without even the
  implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
  PURPOSE.  See the GNU General Public License (GPL) for more details.
  
  You should have received a copy of the GNU General Public License
  (GPL) along with this program.
*/

%{

#include "y.tab.h"
#include "sg.h"

%}

ignore   [,\t\r ]+
s        [\t ]
d        [0-9]
ip       {d}{1,3}\.{d}{1,3}\.{d}{1,3}\.{d}{1,3}
tval     {d}{d}[:]{d}{d}
dval     {d}{d}{d}{d}[\.-]{d}{d}[\.-]{d}{d}
dvalcron ({d}{d}{d}{d}|[\*])[\.-]({d}{d}|[\*])[\.-]({d}{d}|[\*])
weekday  (mon|mondays?|tue|tuesdays?|wed|wednesdays?|thu|thursdays?|fri|fridays?|sat|saturdays?|sun|sundays?)
weekdays (({weekday}{s}*[, \t]+{s}*)*{weekday})|[\*]

%x REDIRECT_STATE
%%

[ \t]*#.*        ;
"{"         return START_BRACKET;
"}"         return STOP_BRACKET; 
^dest        return DESTINATION;
^destination return DESTINATION;
^src         return SOURCE;
^source      return SOURCE;
^rew         return REWRITE;
^rewrite     return REWRITE;
^time        return TIME;
^acl         return ACL;
^dbhome        {yylval.string = yytext ; return DBHOME ;}
^logdir       {yylval.string = yytext ; return LOGDIR ;}
domainlist  return DOMAINLIST;
urllist     return URLLIST;
expressionlist return EXPRESSIONLIST;
iplist      return IPLIST;
user        return USER;
userlist    return USERLIST;
userquota   return USERQUOTA;
domain      return DOMAIN;
pass        return PASS;
rewrite     return REWRITE;
redirect    { BEGIN REDIRECT_STATE; return REDIRECT; }
minutely    return MINUTELY;
hourly      return HOURLY;
daily       return DAILY;
weekly      return WEEKLY;
continuous  return CONTINIOUS;
continue    return CONTINUE;
sporadic    return SPORADIC;
date        return DATE;
anonymous   return ANONYMOUS;
log         return LOGFILE;
logfile     return LOGFILE;
{weekdays} {yylval.string = yytext; return WEEKDAY;}
within return WITHIN;
outside return OUTSIDE;
else return ELSE;
ip          return IP;
{ip}        {yylval.string = yytext; return IPADDR;}
[/]{d}+     {yylval.string = yytext; return CIDR;}
[/]{ip}     {yylval.string = yytext; return IPCLASS;}
{tval}      {yylval.string = yytext; return TVAL;}
{dval}      {yylval.string = yytext; return DVAL;}
{dvalcron}  {yylval.string = yytext; return DVALCRON;}
{d}+        {yylval.string = yytext; return NUMBER;}

<REDIRECT_STATE>[a-zA-Z3\/][a-zA-Z0-9/_\-\.\/\:\%\+\?=&]*  { yylval.string = yytext ; BEGIN 0; return WORD;}
<REDIRECT_STATE>[ \t]+     ;
<REDIRECT_STATE>\n        {lineno++;}
<REDIRECT_STATE>.         {return yytext[0];}
[a-zA-Z\/][a-zA-Z0-9/_\-\.\/\:\%\+\?=&]*  {yylval.string = yytext ; return WORD;}
s@(([^@}]|\\@|\\\})+)@(([^@}]|\\@|\\\})+)@[girR]* {yylval.string = yytext; return SUBST;}
[ \t]+     ;
\n        {lineno++;}
.         {return yytext[0];}


%%



