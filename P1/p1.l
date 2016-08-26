	//FLEX FILE adder.l 
%option noyywrap
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "p1.tab.h" // the output of bison on adder.y
void yyerror(char*); 
int yyparse(void);
%}
DIGIT [0-9]
LETTER [a-zA-Z]
UNDERSCORE "_"
ID ({LETTER}|UNDERSCORE)({LETTER}|{DIGIT})*
BOOL "true"
%%
"class"			return CLASS;
"public"		return PUBLIC;
"static"		return STATIC;
"void"			return VOID;
"main"			return MAIN;
"["				return LBRAC;
"]"				return RBRAC;
"String"		return STRING;
"System.out.println" return PRINT;
"extends"		return EXTENDS
","				return COMMA;
"return"		return RETURN;
"this"			return THIS;
"new"			return NEW;
"!"				return NOT;
"#define"		return HASHDEF;
"int"			return INT;
"boolean"		return BOOLEAN;
{BOOL}			{
					char* temp = (char*) malloc(sizeof(char)*100);
					strcpy(temp,yytext);
					yylval.token_val = temp;
					return BOOLVAL;
				}
"if"			return IF;
"else"			return ELSE;
"while"			return WHILE;
"&&"			return AND;
"||"			return OR;
"!="			return NEQUAL;
"<="			return LEQUAL;
".length"		return DOTLENGTH;
"."				return DOT;
"{"				return LCURL;
"}"				return RCURL;
"+"				return PLUS;
"-"				return SUB;
"*"				return MULT;
"/"				return DIV;
"("				return LPAR;
")"				return RPAR;
"="				return EQUAL; 
";"				return SEMICOLON; 
{DIGIT}+		{ 
					//printf("Saw an integer %s\n",yytext); 
					yylval.int_val = atoi(yytext);
					return INTEGER; 
				}
{ID}			{
					char* temp = (char*) malloc(sizeof(char)*100);
					strcpy(temp,yytext);
					yylval.token_val = temp;
					return ID;
				}
[ \t\n]+		;		//do nothing on whitespace
<<EOF>>			return EOF;
.               { printf("error\n"); return 1;}

%%

void yyerror(char* str) { printf("ERROR: Could not parse!\n"); }

// int yywrap(void) { return 1; }

int main(void) {
	yyparse();	
}
