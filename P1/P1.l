	//FLEX FILE P1.l 
%option noyywrap
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "P1.tab.h" // the output of bison on P1.y
void yyerror(char*); 
int yyparse(void);
%}
DIGIT [0-9]
LETTER [a-zA-Z_$]
ID {LETTER}({LETTER}|{DIGIT})*
NONASCII [\000-\037]
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
"extends"		return EXTENDS;
","				return COMMA;
"return"		return RETURN;
"this"			return THIS;
"new"			return NEW;
"!"				return NOT;
"#define"		return HASHDEF;
"int"			return INT;
"boolean"		return BOOLEAN;
"true"			return TRUE;
"false"			return FALSE;
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
					char* temp = (char*) malloc(sizeof(char)*100);
					strcpy(temp,yytext);
					yylval.token_val = temp;
					return INTEGER; 
				}
{ID}			{
					char* temp = (char*) malloc(sizeof(char)*100);
					strcpy(temp,yytext);
					yylval.token_val = temp;
					return ID;
				}
{NONASCII}+	;
"//".*			;	// do nothing on single line comments
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/] ;	// do nothing on multi-line comments
[ \t\n]+			;		//do nothing on whitespace
<<EOF>>			{return 0;}
.               { printf("// Error while scanning\n"); return 1;}

%%

void yyerror(char* str) { printf("// Failed to parse macrojava code.\n"); }

// int yywrap(void) { return 1; }

int main(void) {
	yyparse();	
}