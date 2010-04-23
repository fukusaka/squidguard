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

#include "sg.h"

extern int sig_hup;           
extern int sig_alrm;           
extern int globalDebugTimeDelta;
extern char **globalArgv;           
extern char **globalEnvp;           
extern struct Acl *defaultAcl;
extern struct LogFileStat *LogFileStat;
extern struct Source *lastActiveSource;

extern struct Source *Source ;
extern struct Destination *Dest ;

#if __STDC__
void sgHandlerSigHUP(int signal)
#else
void sgHandlerSigHUP(signal)
     int signal;
#endif
{
  sig_hup = 1;
}

void sgReloadConfig()
{
  struct LogFileStat *sg;
  struct Source *src;
  struct Destination *dest;
  sig_hup = 0;
  sgLogError("got sigHUP reload config");
  for(sg = LogFileStat; sg != NULL; sg = sg->next){ /* closing logfiles */
    if(sg->fd == stderr || sg->fd == stdout)
      continue;
    fclose(sg->fd);
  }
  for(src = Source; src != NULL; src = src->next){
    if(src->domainDb != NULL && src->domainDb->dbp != NULL)
      (void)src->domainDb->dbp->close(src->domainDb->dbp,0);
    if(src->userDb != NULL && src->userDb->dbp != NULL)
      (void)src->userDb->dbp->close(src->userDb->dbp,0);
  }
  for(dest = Dest; dest != NULL; dest = dest->next){
    if(dest->domainlistDb != NULL && dest->domainlistDb->dbp != NULL)
      (void)dest->domainlistDb->dbp->close(dest->domainlistDb->dbp,0);
    if(dest->urllistDb != NULL && dest->urllistDb->dbp != NULL)
      (void)dest->urllistDb->dbp->close(dest->urllistDb->dbp,0);
  }
  execve(*globalArgv,globalArgv, globalEnvp);
  fprintf(stderr,"error execve: %d\n",errno);
}

#if __STDC__
void sgAlarm(int signal)
#else
void sgAlarm(signal)
     int signal;
#endif
{
  sig_alrm = 1;
  sgTimeNextEvent();
}

/*
  parsers the squidline:
  URL ip-address/fqdn ident method
*/

#if __STDC__
int parseLine(char *line, struct SquidInfo *s)
#else
int parseLine(line, s)
     char *line;
     struct SquidInfo *s;
#endif
{
  char *p, *d = NULL, *a = NULL, *e = NULL, *o, *field;
  char *up, *upp;
  int i = 0, hex;
  char c,h1,h2;
  field = strtok(line,"\t ");
  if(field == NULL)
    return 0;
  strcpy(s->orig,field);
  for(p=field; *p != '\0'; p++) /* convert url to lowercase chars */
    *p = tolower(*p);
  s->url[0] = s->protocol[0] = s->domain[0] = s->src[0] = s->ident[0] = 
    s->method[0] = s->srcDomain[0] = s->surl[0] =  '\0';
  s->dot = 0;
  s->port = 0;
  p = strstr(field,"://");
  if(p == NULL) { /* no protocl, defaults to http */
    strcpy(s->protocol,"unknown");
    p = field;
  } else {
    strncpy(s->protocol,field,p - field);
    *(s->protocol + ( p - field)) = '\0';
    p+=3;
  }
    /*do some url decoding */
  up=field;
  upp= s->url;
  while(up[i] != '\0'){
    if(up[i] == '%'){
      if(isxdigit(up[i+1]) && isxdigit(up[i+2])){
        h1 = up[i+1] >= 'a' ? up[i+1] - ('a' - 'A') : up[i+1];
        h2 = up[i+2] >= 'a' ? up[i+2] - ('a' - 'A') : up[i+2];
        hex = h1 >= 'A' ? h1 - 'A' - 10 : h1 - '0';
        hex *= 16;
        hex += h2 >= 'A' ? h2 - 'A' - 10 : h2 - '0';
	/* don't convert whitespace, newline and carriage return */
	if(hex == 0x20 || hex == 0x09 || hex == 0x0a || hex == 0x0d){
	  *upp++ = up[i++];
	  *upp++ = up[i++];
	  *upp++ = up[i];
	} else { 
	  *upp++ = hex;
	  i+=2;
	}
      } else { /* an errorous hex code, we ignore it */
        *upp++ = up[i++];
        *upp++ = up[i++];
        *upp++ = up[i];
      }
    } else {
      *upp++ = up[i];
    }
    i++;
  }
  *upp++=up[i];
  *upp='\0';
  i=0;
  d = strchr(p,'/'); /* find domain end */
  e = d;
  a = strchr(p,'@'); /* find auth  */
  if(a != NULL && ( a < d || d == NULL)) 
    p = a + 1;
  a = strchr(p,':'); /* find port */;
  if(a != NULL && (a < d || d == NULL)){
    o = a + strspn(a+1,"0123456789") + 1;
    c = *o;
    *o = '\0';
    s->port = atoi(a+1);
    *o = c;
    e = a;
  }
  o=p;
  if (p[0] == 'w' || p[0] == 'f' ) {
    if ((p[0] == 'w' && p[1] == 'w' && p[2] == 'w') ||
	(p[0] == 'w' && p[1] == 'e' && p[2] == 'b') ||
	(p[0] == 'f' && p[1] == 't' && p[2] == 'p')) {
      p+=3;
      while (p[0] >= '0' && p[0] <= '9')
	p++;
      if (p[0] != '.')
	p=o; /* not a hostname */
      else
	p++;
    }
  }
  if(e == NULL){
    strcpy(s->domain,o);
    strcpy(s->surl,p);
  }
  else {
    strncpy(s->domain,o,e - o);
    strcpy(s->surl,p);
    *(s->domain + (e - o)) = '\0';
    *(s->surl + (e - p)) = '\0';
  }
  //strcpy(s->surl,s->domain);
  if(strspn(s->domain,".0123456789") == strlen(s->domain))
    s->dot = 1;
  if(d != NULL)
    strcat(s->surl,d);
  s->strippedurl = s->surl;
  while((p = strtok(NULL," \t\n")) != NULL){
    switch(i){
    case 0: /* src */
      o = strchr(p,'/');
      if(o != NULL){
	strncpy(s->src,p,o-p);
	strcpy(s->srcDomain,o+1);
	s->src[o-p]='\0';
	if(*s->srcDomain == '-')
	  s->srcDomain[0] = '\0';
      } else
	strcpy(s->src,p);
      break;
    case 1: /* ident */
      if(strcmp(p,"-")){
	strcpy(s->ident,p);
	for(p=s->ident; *p != '\0'; p++) /* convert ident to lowercase chars */
	  *p = tolower(*p);
      } else
	s->ident[0] = '\0';
      break;
    case 2: /* method */
      strcpy(s->method,p);
      break;
    }
    i++;
  }
  if(s->domain[0] == '\0')
    return 0;
  if(s->method[0] == '\0')
    return 0;
  return 1;
}

#if __STDC__
char *sgStripUrl (char *url)
#else
char *sgStripUrl (url)
     char *url;
#endif
{
  static char newurl[MAX_BUF];
  char *p, *d = NULL, *a = NULL, *e = NULL;
  p = url;
  d = strchr(p,'/'); /* find domain end */
  e = d;
  a = strchr(p,'@'); /* find auth  */
  if(a != NULL && ( a < d || d == NULL)) 
    p = a + 1;
  a = strchr(p,':'); /* find port */;
  if(a != NULL && (a < d || d == NULL))
    e = a;
  if(e == NULL)
    strcpy(newurl,p);
  else {
    strncpy(newurl,p,e - p);
    *(newurl + (e - p)) = '\0';
  }
  if(d != NULL)
    strcat(newurl,d);
  return newurl;
}

/* 
   returns a pointer to the domain part of a fully-qualified  hostname
   so www.abc.xyz.dom/index.html -> xyz.dom/index.html
*/

#if __STDC__
char *sgSkipHostPart (char *domain)
#else
char *sgSkipHostPart (domain)
     char *domain;
#endif
{
  char *p = domain , *d1 = NULL, *d2 = NULL, *path = NULL;
  if((path = (char *) strchr(p,'/')) == NULL)
    path = domain; 
  while((p = (char *) strchr(p,'.')) != NULL ){
    if(p > path && path != domain)
      break;
    d2 = d1;
    d1 = p;
    p++;
  }
  if(d2 != NULL)
    return d2+1;
  return domain;
}

#if __STDC__
void *sgMalloc(size_t elsize)
#else
void *sgMalloc(elsize)
     size_t elsize;
#endif
{
  void *p;
  if((p=(void *) malloc(elsize)) == NULL){
    sgLogFatalError("%s: %s",progname,strerror(ENOMEM));
    exit(1);
  }
  return (void *) p;
}

#if __STDC__
void *sgCalloc(size_t nelem, size_t elsize)
#else
void *sgCalloc(nelem, elsize)
     size_t nelem;
     size_t elsize;
#endif
{
  void *p;
  if((p=(void *) calloc(nelem,elsize)) == NULL){
    sgLogFatalError("%s: %s",progname,strerror(ENOMEM));
    exit(1);
  }
  return (void *) p;
}


#if __STDC__
void *sgRealloc(void *ptr, size_t elsize)
#else
void *sgRealloc(ptr, elsize)
     void *ptr;
     size_t elsize;
#endif
{
  void *p;
  if((p=(void *) realloc(ptr,elsize)) == NULL){
    sgLogFatalError("%s: %s",progname,strerror(ENOMEM));
    exit(1);
  }
  return (void *) p;
}

#if __STDC__
void sgFree(void *ptr)
#else
void sgFree(ptr)
     void *ptr;
#endif
{
  free(ptr);
}


/*

checks the vality of an dotted address. 

*/

#if __STDC__
ulong *sgConvDot (char *dot)
#else
ulong *sgConvDot (dot)
     char *dot;
#endif
{
  static unsigned long ipaddr = 0;
  int octet;
  char *s = dot,*t;
  int shift = 24;
  ipaddr = 0;
  while(*s){
    t = s;
    if (!isdigit(*t))
      return NULL;
    while (isdigit(*t)) 
      ++t;
    if (*t == '.') 
      *t++ = 0;
    else if (*t) 
      return NULL;
    if(shift < 0)
      return NULL;
    octet = atoi(s);
    if(octet < 0 || octet > 255)
      return NULL;
    ipaddr |= octet << shift;
    s=t;
    shift -=8;
  }
  return &ipaddr;
}


/*
 Reverses cmp of strings
*/

#if __STDC__
int sgStrRcmp(char *a, char *b)
#else
int sgStrRcmp(a, b)
     char *a;
     char *b;
#endif
{
  char *a1 = (char *) strchr(a,'\0');
  char *b1 = (char *) strchr(b,'\0');
  while(*a1 == *b1){
    if(b1 == b || a1 == a)
      break;
    a1--; b1--;
  }
  if(a1 == a && b1 == b)
    return *a1 - *b1; 
  if(a1 == a)
    return -1;
  if(b1 == b)
    return 1;
  return *a1 - *b1;
}

#if __STDC__
int sgStrRncmp(char *a, char *b, int blen)
#else
int sgStrRncmp(a, b, blen)
     char *a;
     char *b;
     int blen;
#endif
{
  char *a1 = (char *) strchr(a,'\0');
  char *b1 = (char *) strchr(b,'\0');
  while(*a1 == *b1 && blen > 0 ){
    if(b1 == b || a1 == a)
      break;
    a1--; b1--; blen--;
  }
  if(a1 == a && b1 == b)
    return *a1 - *b1; 
  if(blen == 0)
    return *a1 - *b1;
  if(a1 == a)
    return -1;
  if(b1 == b)
    return 1;
  return *a1 - *b1;
}

/*

  sgDomStrRncmp checks if B is equal to or a subdomain of A

 */


#if __STDC__
int sgDomStrRcmp(char *p1, char *p2)
#else
int sgDomStrRncmp(p1, p2)
     char *p1;
     char *p2;
#endif
{
  char *p11 = (char *) strchr(p1,'\0');
  char *p22 = (char *) strchr(p2,'\0');
  for(;p11 >= p1 && p22 >= p2 && *p11 == *p22; p11--, p22--);
  if(p11 < p1 && p22 < p2)
    return 0;
  if(p22 < p2)
    return -*p11;
  if(p11 < p1 && *p22 == '.')
    return 0;
  return *p11 - *p22;
}

/*

  Regexp functions
  
*/

#if __STDC__
struct sgRegExp *sgNewPatternBuffer(char *pattern, int flags)
#else
struct sgRegExp *sgNewPatternBuffer(pattern, flags)
     char *pattern;
     int flags;
#endif
{
  regex_t *compiled = (regex_t *) sgCalloc(1,sizeof(regex_t));
  struct sgRegExp *regexp;
  regexp=(struct sgRegExp *) sgCalloc(1,sizeof(struct sgRegExp));
  regexp->pattern = (char *) sgCalloc(1,strlen(pattern) + 1);
  strcpy(regexp->pattern, pattern);
  regexp->error = 0;
  regexp->next = NULL;
  regexp->flags = flags;
  regexp->error = regcomp(compiled, pattern, flags);
  regexp->compiled = compiled;
  return regexp;
}

#if __STDC__
char *sgRegExpSubst(struct sgRegExp *regexp, char *pattern)
#else
char *sgRegExpSubst(regexp, pattern)
     struct sgRegExp *regexp;
     char *pattern;
#endif
{
  struct sgRegExp *re;
  regmatch_t pm;
  static char newstring[MAX_BUF];
  char *result = NULL, *p;
  int substlen;
  *newstring='\0';
  for(re = regexp; re != NULL; re = re->next){
    if (regexec (re->compiled, pattern, 1, &pm, 0) != 0){
      result = NULL;
    } else {
      substlen = strlen(re->substitute);
      if(re->httpcode != NULL)
	strcpy(newstring,re->httpcode);
      else
	*newstring = '\0';
      p = newstring;
      do {
	if((p - newstring)+ pm.rm_so  >= MAX_BUF)
	  break;
	p = strncat(newstring,pattern,pm.rm_so);
	if((p - newstring)+ substlen  >= MAX_BUF)
	  break;
	p = strcat(newstring,re->substitute);	
	pattern = pattern + pm.rm_eo;
      } while(regexec (re->compiled, pattern, 1, &pm, REG_NOTBOL)== 0 &&
	      re->global);
      if((p - newstring)+ strlen(pattern)  <= MAX_BUF)
	p = strcat(newstring,pattern);
      result = newstring;
      break;
    }
  }
  return result;
}

/*

  

 */


#if __STDC__
char *sgParseRedirect(char *redirect,
		      struct SquidInfo *req,
		      struct Acl *acl, 
		      struct AclDest *aclpass)
#else
char *sgParseRedirect(redirect, req, acl, aclpass)
     char *redirect;
     struct SquidInfo *req;
     struct Acl *acl;
     struct AclDest *aclpass;
#endif
{
  static char buf[MAX_BUF + MAX_BUF];
  char *p = redirect, *q = NULL, *t = NULL;
  struct Source *s = lastActiveSource;
  *buf= '\0';
  if(aclpass == NULL)
    aclpass = defaultAcl->pass;
  while((p = strchr(p,'%')) != NULL){
    if(q == NULL){
      strncpy(buf,redirect, p - redirect);
      buf[p - redirect] = '\0';
    } else {
      strncat(buf, q,  p - q);
    }
    if(p == NULL)
      break;
    switch(*(p + 1)){
    case 'a': /* Source Address */
      strcat(buf, req->src);
      p++;
      break;
    case 'i': /* Source User Ident */
      if (!strcmp(req->ident, "-")) {
	strcat(buf, "unknown");
      } else {
	strcat(buf, req->ident);
      }
      p++;
      break;
    case 'q': /* userquota info */
      if(s != NULL && s->userquota.seconds != 0 && strcmp(req->ident, "-")) {
	struct UserQuotaInfo *userquota;
	if(defined(s->userDb, req->ident, (char **) &userquota) == 1){
	  char qbuf[150];
	  sprintf(qbuf, "%d-%d-%d-%d-%d-%d", 
		  s->userquota.renew, s->userquota.seconds, userquota->status,
		  userquota->time, userquota->last, userquota->consumed);
	  strcat(buf, qbuf);
	} else {
	  strcat(buf, "noquota");
	}
      } else {
	strcat(buf, "noquota");
      }
    case 'n': /* Source Domain Name */
      if (!strcmp(req->srcDomain, "-")) {
	strcat(buf, "unknown");
      } else {
	strcat(buf, req->srcDomain);
      }
      p++;
      break;
    case 'p': /* The url path */
      if((t = strstr(req->orig,"//")) != NULL){
        t+=2;
        if((t=strchr(t,'/')) != NULL)
	  strcat(buf,++t);
      }
      p++;
      break;
    case 'f': /* The url file */
      if((t = strrchr(req->orig,'/')) != NULL){
        t++;
        strcat(buf,t);
      }
      p++;
      break;
    case 's': /* Source Class Matched */
      if(acl->source == NULL || acl->source->name == NULL)
	strcat(buf, "default");
      else
	strcat(buf, acl->source->name);
      p++;
      break;
    case 't': /* Target Class Matched */
      if(aclpass == NULL)
	strcat(buf, "unknown");
      else if(aclpass->name == NULL)
	if(aclpass->type == ACL_TYPE_INADDR)
	  strcat(buf,"in-addr");
	else if(aclpass->type == ACL_TYPE_TERMINATOR)
	  strcat(buf, "none");
	else
	  strcat(buf, "unknown");
      else
	strcat(buf, aclpass->name);
      p++;
      break;
    case 'u': /* Requested URL */
      strcat(buf, req->orig);
      p++;
      break;
    default:
      strcat(buf, "%")
      ;
    }
    p++;
    q = p;
  }
  if(buf[0] == '\0')
    q = redirect;
  else 
    q = buf;
  return q;
}

#if __STDC__
void sgEmergency ()
#else
void sgEmergency ()
#endif
{
  char buf[MAX_BUF];
  sgLogError("going into emergency mode");
  while(fgets(buf, MAX_BUF, stdin) != NULL){
    puts("");
    fflush(stdout);
  }
  sgLogError("ending emergency mode, stdin empty");
  exit(-1);
}


/*
converts yyyy.mm.ddTHH:MM:SS to seconds since EPOC
 */

#if __STDC__
time_t iso2sec(char *date)
#else
time_t iso2sec(date)
     char *date;
#endif
{
  struct tm *t;
  int y,m,d,H,M,S;
  t = (struct tm *) sgCalloc(1,sizeof(struct tm));
  sscanf(date,"%4d%*[.-]%2d%*[.-]%2d%*[T]%2d%*[:-]%2d%*[:-]%2d",
	 &y,&m,&d,&H,&M,&S);
  m--; 
  y = y - 1900;
  if(y < 0 || m < 0 || m > 11 || d < 1 || d > 31 || H < 0 || H > 23 
     || M < 0 || M > 59 || S < 0 || S > 59)
    return (time_t) -1;
  t->tm_year = y;
  t->tm_mon =  m;
  t->tm_mday = d;
  t->tm_hour = H;
  t->tm_min = M;
  t->tm_sec = S;
  return (time_t) mktime(t);
}

/*
converts yyyy.mm.dd to seconds since EPOC
 */

#if __STDC__
time_t date2sec(char *date)
#else
time_t date2sec(date)
     char *date;
#endif
{
  struct tm *t;
  int y,m,d;
  t = (struct tm *) sgCalloc(1,sizeof(struct tm));
  sscanf(date,"%4d%*[.-]%2d%*[.-]%2d",&y,&m,&d);
  m--; 
  y = y - 1900;
  if(y < 0 || m < 0 || m > 11 || d < 1 || d > 31)
    return (time_t) -1;
  t->tm_year = y;
  t->tm_mon =  m;
  t->tm_mday = d;
  return (time_t) mktime(t);
}

#if __STDC__
char *niso(time_t t)
#else
char *niso(t)
     time_t t;
#endif
{
  static char buf[20];
  time_t tp;
  struct tm *lc;
  if(t == 0)
    tp = time(NULL) + globalDebugTimeDelta;
  else
    tp = t;
  lc = localtime(&tp);
  sprintf(buf,"%04d-%02d-%02d %02d:%02d:%02d",lc->tm_year + 1900,lc->tm_mon + 1,
	  lc->tm_mday, lc->tm_hour,lc->tm_min,lc->tm_sec);
  return buf;
}

#if __STDC__
struct UserQuotaInfo *setuserquota()
#else
struct UserQuotaInfo *setuserquota()
#endif
{
  static struct UserQuotaInfo uq;
  uq.status = 0; 
  uq.time = 0; 
  uq.consumed = 0; 
  uq.last = 0; 
  return &uq;
}

