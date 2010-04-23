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

%}

%union {
  char *string;
  char *tval;
  char *dval;
  char *dvalcron;
  int  *integer;
}

%token WORD END START_BRACKET STOP_BRACKET WEEKDAY
%token DESTINATION REWRITE ACL TIME TVAL DVAL DVALCRON
%token SOURCE CIDR IPCLASS CONTINUE
%token IPADDR DBHOME DOMAINLIST URLLIST EXPRESSIONLIST IPLIST
%token DOMAIN USER USERLIST USERQUOTA IP NL NUMBER
%token PASS REDIRECT LOGDIR SUBST CHAR MINUTELY HOURLY DAILY WEEKLY DATE
%token WITHIN OUTSIDE ELSE LOGFILE ANONYMOUS CONTINIOUS SPORADIC

%type <string> WORD 
%type <string> WEEKDAY
%type <string> NUMBER
%type <tval> TVAL
%type <string> DVAL
%type <string> DVALCRON
%type <string> CHAR
%type <string> SUBST 
%type <string> IPADDR
%type <string> DBHOME LOGDIR
%type <string> CIDR
%type <string> IPCLASS
%type <string> acl_content
%type <string> acl
%type <string> dval
%type <string> dvalcron
%type <string> tval
%type <string> date
%type <string> ttime
%%

start: statements
       ; 



dbhome:    DBHOME WORD { sgSetting("dbhome",$2); }
         ;

logdir:    LOGDIR WORD { sgSetting("logdir",$2); }
         ;

start_block:
               START_BRACKET
	       ;

stop_block:
               STOP_BRACKET
	       ;

destination: DESTINATION WORD { sgDest($2); }
             ;

destination_block: destination start_block destination_contents stop_block 
                       { sgDestEnd();}
                ;

destination_contents:
                  | destination_contents destination_content
		  ;
destination_content:  
 	    DOMAINLIST WORD { sgDestDomainList($2); }
            | DOMAINLIST '-' { sgDestDomainList(NULL); }
            | URLLIST WORD { sgDestUrlList($2); }
            | URLLIST '-'  { sgDestUrlList(NULL); }
            | EXPRESSIONLIST '-' { sgDestExpressionList(NULL,NULL); }
            | EXPRESSIONLIST 'i' WORD { sgDestExpressionList($3,"i"); }
            | EXPRESSIONLIST WORD  { sgDestExpressionList($2,"n"); }
            | REDIRECT WORD  {sgDestRedirect($2); }
            | REWRITE WORD  {sgDestRewrite($2); }
            | WITHIN WORD { sgDestTime($2,WITHIN); }
            | OUTSIDE WORD { sgDestTime($2,OUTSIDE); }
            | LOGFILE ANONYMOUS WORD { sgLogFile(SG_BLOCK_DESTINATION,1,$3); }
            | LOGFILE WORD { sgLogFile(SG_BLOCK_DESTINATION,0,$2); }
            ;

source:      SOURCE WORD { sgSource($2); }
             ;

source_block: source start_block source_contents stop_block {sgSourceEnd();}
             ;

source_contents:
		    | source_contents source_content
		    ;


source_content:     DOMAIN domain
                    | USER user 
                    | USERLIST WORD { sgSourceUserList($2); } 
                    | USERQUOTA NUMBER NUMBER HOURLY { 
		      sgSourceUserQuota($2,$3,"3600");} 
                    | USERQUOTA NUMBER NUMBER DAILY { 
		      sgSourceUserQuota($2,$3,"86400");} 
                    | USERQUOTA NUMBER NUMBER WEEKLY { 
		      sgSourceUserQuota($2,$3,"604800");} 
                    | USERQUOTA NUMBER NUMBER NUMBER { 
		      sgSourceUserQuota($2,$3,$4);} 
                    | IP ips
                    | IPLIST WORD { sgSourceIpList($2); }
                    | WITHIN WORD { sgSourceTime($2,WITHIN); }
                    | OUTSIDE WORD { sgSourceTime($2,OUTSIDE); }
                    | LOGFILE ANONYMOUS WORD {sgLogFile(SG_BLOCK_SOURCE,1,$3);}
                    | LOGFILE WORD { sgLogFile(SG_BLOCK_SOURCE,0,$2); }
                    | CONTINUE { lastSource->cont_search = 1; }
                    ;


domain:		    
		    | domain WORD { sgSourceDomain($2); }
                    | domain ','
		    ;

user:		    
		    | user WORD { sgSourceUser($2); }
                    | user ','
		    ;

acl_block: ACL start_block acl_contents stop_block 
             ;

acl_contents:
		    | acl_contents acl_content
		    ;

acl:            WORD {sgAcl($1,NULL,0);}
               | WORD WITHIN WORD {sgAcl($1,$3,WITHIN);}
               | WORD OUTSIDE WORD { sgAcl($1,$3,OUTSIDE); }
                ;

acl_content:     acl start_block access_contents stop_block
                 | acl start_block access_contents stop_block ELSE
                   {sgAcl(NULL,NULL,ELSE);} 
                       start_block access_contents stop_block
                 ;

access_contents:
                   | access_contents access_content
                   ;

access_content:    PASS access_pass { }
                  | REWRITE WORD { sgAclSetValue("rewrite",$2,0); }
                  | REDIRECT WORD { sgAclSetValue("redirect",$2,0); }
                  | LOGFILE ANONYMOUS WORD {sgLogFile(SG_BLOCK_ACL,1,$3);}
                  | LOGFILE WORD { sgLogFile(SG_BLOCK_ACL,0,$2); }
                  ;

access_pass:     
                  | access_pass WORD { sgAclSetValue("pass",$2,1);}
                  | access_pass '!' WORD { sgAclSetValue("pass",$3,0);}
		  | access_pass ',' 
                  ;

cidr:             CIDR { sgIp($1); }
                  ;

ipclass:          IPCLASS { sgIp($1); }
                  ;
ips: 		   
                    | ips ip { sgIp("255.255.255.255") ; sgSetIpType(SG_IPTYPE_HOST,NULL,0); }
                    | ips ip cidr { sgSetIpType(SG_IPTYPE_CIDR,NULL,0); }
                    | ips ip ipclass { sgSetIpType(SG_IPTYPE_CLASS,NULL,0); }
                    | ips ip '-' ip  { sgSetIpType(SG_IPTYPE_RANGE,NULL,0); }
                    | ips ','
		    ;

ip:  IPADDR { sgIp($1);}
     ;

rew:       REWRITE WORD { sgRewrite($2); }

rew_block:  rew start_block rew_contents stop_block 
             ;

rew_contents:
		    | rew_contents rew_content
		    ;


rew_content:    SUBST  { sgRewriteSubstitute($1); }
                | WITHIN WORD { sgRewriteTime($2,WITHIN); }
                | OUTSIDE WORD { sgRewriteTime($2,OUTSIDE); }
                | LOGFILE ANONYMOUS WORD { sgLogFile(SG_BLOCK_REWRITE,1,$3); }
                | LOGFILE WORD { sgLogFile(SG_BLOCK_REWRITE,0,$2); }
                ;


time:       TIME WORD { sgTime($2); }

time_block:  time start_block time_contents stop_block 
             ;

time_contents:
		    | time_contents time_content
		    ;


time_content:    WEEKLY {sgTimeElementInit();} WORD 
                         {sgTimeElementAdd($3,T_WEEKLY);} ttime
                 | WEEKLY {sgTimeElementInit();} WEEKDAY
                         {sgTimeElementAdd($3,T_WEEKDAY);} ttime
                 | DATE {sgTimeElementInit();} date 
                         {sgTimeElementEnd();}
                 ;

ttime:           ttime { sgTimeElementClone(); } tval '-' tval
		 | tval '-' tval 
                 ;

date:            dval ttime
                 | dval 
                 | dval '-' dval ttime
                 | dval '-' dval 
                 | dvalcron ttime
                 | dvalcron
                 ;

dval:		 DVAL { sgTimeElementAdd($1,T_DVAL);}
                 ;

tval:		 TVAL { sgTimeElementAdd($1,T_TVAL);}
                 ;

dvalcron:	 DVALCRON { sgTimeElementAdd($1,T_DVALCRON);}
                 ;

statements:
       | statements statement
       ;

statement:   
             destination
	     | source_block
	     | destination_block
             | dbhome
	     | logdir
	     | acl_block
	     | rew_block
	     | time_block
	     | NL
             ;

%%

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
