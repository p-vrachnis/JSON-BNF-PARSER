%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

FILE *yyin;
void yyerror(const char *s);
extern char* yytext;

%}

%token QUOT
%token STRING
%token INT_NUMBER
%token TEXT_LEX
%token A_MONTH
%token A_DAY
%token ID_S_LEX
%token STR_NUMBER
%token USER_LEX
%token ID_LEX
%token NAME_LEX
%token SCR_NM_LEX
%token LOC_LEX
%token CRT_LEX
%token RT_LEX
%token TWT_LEX
%token TRUNCATED
%token EXT_TW_LEX
%token TRUE_LEX
%token FALSE_LEX
%token FULL_TEXT
%token DISPLAY_TEXT_RANGE

%%
json: 				'{' main_jsn '}' ;
main_jsn: 				commands | main_jsn ',' commands;

commands: 			 created_at| id_str |user|	text  
					 |retweeted_status 
					|  truncated | extended_tweet | tweet
					|json_tags;


created_at: 		CRT_LEX ':'  A_DAY A_MONTH INT_NUMBER INT_NUMBER ':' INT_NUMBER ':' INT_NUMBER  INT_NUMBER  ;
					
user: 				USER_LEX ':' '{' ujson  '}' ;

ujson:			 	user_parts 
					| ujson ',' user_parts;
					
user_parts: 		id | name 
					| screen_name 
					| location |json_tags;



id: 					ID_LEX ':' INT_NUMBER;
name: 					NAME_LEX ':' STRING;
screen_name: 			SCR_NM_LEX ':' STRING;

location: 				LOC_LEX ':' STRING; 
		
id_str: 				ID_S_LEX ':' STR_NUMBER  ;	
text: 				TEXT_LEX ':' STRING ;		




json_tags: 						STRING ':' STRING ;



retweeted_status: 			RT_LEX ':' '{' json_rt  '}' ;

json_rt: 					text ',' user;

tweet: 						TWT_LEX ':' '{' json_rt  '}' ;



truncated: 					TRUNCATED ':' TRUE_LEX ',' display_text_range ;
display_text_range: 		DISPLAY_TEXT_RANGE ':' array_num;

extended_tweet: 			EXT_TW_LEX '{' full_text ',' display_text_range '}';
full_text : 				FULL_TEXT ':' STRING;



array_num : 				'[' nums ']';
array_string:				'[' strings ']';
nums: 						INT_NUMBER | nums ',' INT_NUMBER;
strings: 					STRING | STRING ',' STRING;


%%

void yyerror(const char *s) {
	printf(" - Error !!!\n"); exit(1);

}

int main(int argc, char* argv[]) {
	FILE *f;
	
		f = fopen(argv[1], "r");
		yyin = f;
		yyparse();
		printf("Compilation completed successfully!\n");
		return 0;

}


