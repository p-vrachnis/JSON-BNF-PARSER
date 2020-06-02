%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "parser.tab.h"

%}

DIGIT [0-9]
DIGITS 		{DIGIT}+
HEXS [0-9a-f]

ALL_CHARS [ -!#-\[\]-~]
ESC_CHARS \\["\\bfnrt/]

UNCD \\u{HEXS}{HEXS}{HEXS}{HEXS}
CHAR {ALL_CHARS}|{ESC_CHARS}|{UNCD} 

CHARS_A {CHAR}+	
%%

\"user\"				{printf("%s", yytext); return USER_LEX; }

\"text\"				{printf("%s", yytext); return TEXT_LEX; }	

\"location\"			{printf("%s", yytext); return LOC_LEX; }

\"name\"				{printf("%s", yytext); return NAME_LEX; }

\"screen_name\"			{printf("%s", yytext); return SCR_NM_LEX; }

\"id_str\"				{printf("%s", yytext); return ID_S_LEX; }

\"id\"					{printf("%s", yytext); return ID_LEX; }

\"created_at\"				{printf("%s", yytext); return CRT_LEX; }

\"retweeted_status\"		{printf("%s", yytext); return RT_LEX; }

\"tweet\"					{printf("%s", yytext); return TWT_LEX; }

\"extended_tweet\"			{printf("%s", yytext); return EXT_TW_LEX; }

\"true\"					{printf("%s", yytext); return TRUE_LEX; }

\"false\"					{printf("%s", yytext); return FALSE_LEX; }

Mon|Thu|Wed|Tue|Fri|Sat|Sun							{ printf("%s", yytext); return A_DAY;}
Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec		{printf("%s",yytext); return A_MONTH;}


\{		{printf("{"); return '{';}

\}		{printf("}"); return '}';}

\[		{printf("{"); return '[';}

\]		{printf("}"); return ']';}

\"		{printf("\""); return QUOT;}

,		{printf(","); return ',';}

:		{printf(":"); return ':';}

	
\"{DIGITS}\"		{printf("%s", yytext); return STR_NUMBER; }

\"{CHARS_A}\"		{printf("%s", yytext); return STRING; }	

{DIGITS}			{printf("%s", yytext); return INT_NUMBER; }




	
%%
