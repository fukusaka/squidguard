/*
  By accepting this notice, you agree to be bound by the following
  agreements:
  
  This software product, squidGuard, is copyrighted (C) 1998-2009
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

#include "sg.h"

extern int globalDebug;    /* from main.c */
extern int globalPid;      /* from main.c */
extern char *globalLogDir; /* from main.c */
extern struct LogFileStat *globalErrorLog;

#if __STDC__
void sgSetGlobalErrorLogFile()
#else
void sgSetGlobalErrorLogFile()
#endif
{
  static char file[MAX_BUF];
  if(globalDebug)
    return;
  if(globalLogDir == NULL)
    strncpy(file,DEFAULT_LOGDIR,MAX_BUF);
  else
    strncpy(file,globalLogDir,MAX_BUF);
  strcat(file,"/");
  strcat(file,DEFAULT_LOGFILE);
  globalErrorLog = sgLogFileStat(file);
}

#if __STDC__
void sgLog(struct LogFileStat *log, char *format, ...)
#else
void sgLog(log, format, va_alist)
     struct LogFileStat *log;
     char *format;
     va_dcl
#endif
{
  FILE *fd;
  char *date = NULL;
  char msg[MAX_BUF];
  va_list ap;
  VA_START(ap, format);
  if(vsnprintf(msg, MAX_BUF, format, ap) > (MAX_BUF - 1)) 
    fprintf(stderr,"overflow in vsnprintf (sgLog): %s",strerror(errno));
  va_end(ap);
  date = niso(0);
  if(globalDebug || log == NULL) {
    fprintf(stderr, "%s [%d] %s\n", date,globalPid, msg);
    fflush(stderr);
  } else {
    fd = log->fd;
    if(fd == NULL){
      globalDebug = 1;
      fprintf(stderr,"%s [%d] filedescriptor closed for  %s\n",
	      date,globalPid ,log->name);
      fprintf(stderr, "%s [%d] %s\n", date, globalPid, msg);
    } else {
      fprintf(fd, "%s [%d] %s\n", date, globalPid, msg);
      fflush(fd);
    }
  }
}

#if __STDC__
void sgLogError(char *format, ...)
#else
void sgLogError(format, va_alist)
     char *format;
     va_dcl
#endif
{
  char msg[MAX_BUF];
  va_list ap;
  VA_START(ap, format);
  if(vsnprintf(msg, MAX_BUF, format, ap) > (MAX_BUF - 1)) 
    sgLog(globalErrorLog, "overflow in vsnprintf (sgLogError): %s",strerror(errno));
  va_end(ap);
  sgLog(globalErrorLog,"%s",msg);
}

#if __STDC__
void sgLogFatalError(char *format, ...)
#else
void sgLogFatalError(format, va_alist)
     char *format;
     va_dcl
#endif
{
  char msg[MAX_BUF];
  va_list ap;
  VA_START(ap, format);
  if(vsnprintf(msg, MAX_BUF, format, ap) > (MAX_BUF - 1)) 
    sgLog(globalErrorLog, "overflow in vsnprintf (sgLogError): %s",strerror(errno));
  va_end(ap);
  sgLog(globalErrorLog,"%s",msg);
  sgEmergency();
}


#if __STDC__
void sgLogRequest(struct LogFile *log,
		  struct SquidInfo *req,
		  struct Acl *acl, 
		  struct AclDest *aclpass,
                 struct sgRewrite *rewrite,
                 int request)
#else
void sgLogRequest(log, req, acl, aclpass, rewrite, request)
     struct LogFile *log;
     struct SquidInfo *req;
     struct Acl *acl;
     struct AclDest *aclpass;
     struct sgRewrite *rewrite;
     int request;
#endif
{
  char *ident = req->ident;
  char *srcDomain = req->srcDomain;
  char *srcclass, *targetclass;
  char *rew;
  char *action;
  switch(request)
  {
  case REQUEST_TYPE_REWRITE:
    action = "REWRITE";
    break;
  case REQUEST_TYPE_REDIRECT:
    action = "REDIRECT";
    break;
  case REQUEST_TYPE_PASS:
    if(!log->verbose)
      return;
    action = "PASS";
    break;
  default:
    action = "-";
    break;
  }
  if(rewrite == NULL) 
    rew = "-";
  else 
    rew = rewrite->name;
  if(*ident == '\0' || log->anonymous == 1)
    ident = "-";
  if(*srcDomain == '\0')
    srcDomain = "-";
  if(acl->source == NULL || acl->source->name == NULL)
    srcclass = "default";
  else
    srcclass = acl->source->name;
  if(aclpass == NULL)
    targetclass = "unknown";
  else if(aclpass->name == NULL) {
     if(aclpass->type == ACL_TYPE_INADDR)
       targetclass = "in-addr";
    else if(aclpass->type == ACL_TYPE_TERMINATOR)
      targetclass = "none";
    else
      targetclass = "unknown";
  }
  else
    targetclass =  aclpass->name;
  sgLog(log->stat,"Request(%s/%s/%s) %s %s/%s %s %s %s",
	srcclass,
	targetclass,
	rew,
        req->orig,
       req->src,
       srcDomain,
	ident,
       req->method,
       action
	);
}


