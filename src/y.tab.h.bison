typedef union {
  char *string;
  char *tval;
  char *dval;
  char *dvalcron;
  int  *integer;
} YYSTYPE;
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


extern YYSTYPE yylval;
