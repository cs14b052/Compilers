/* BISON FILE adder.y */

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern int yylex();
extern void yyerror(char *);
void print(int);
%}

%union {
	int	int_val;
	char* token_val;
};

%token <token_val>  CLASS PUBLIC STATIC VOID MAIN LBRAC RBRAC STRING PRINT EXTENDS COMMA RETURN THIS NEW NOT HASHDEF INT BOOLEAN IF ELSE WHILE AND OR NEQUAL LEQUAL DOTLENGTH DOT LCURL RCURL PLUS SUB MULT DIV LPAR RPAR EQUAL SEMICOLON ID BOOLVAL
%token<int_val> INTEGER

%type <token_val> Goal
%type <token_val> MacroDefinitionStar
%type <token_val> TypeDeclarationStar
%type <token_val> MainClass
%type <token_val> TypeDeclaration
%type <token_val> ClassBody
%type <token_val> TypeIdStar
%type <token_val> MethodDeclarationStar
%type <token_val> MethodDeclaration
%type <token_val> StatementStar
%type <token_val> Arguments
%type <token_val> additionalArguments
%type <token_val> Type
%type <token_val> Statement
%type <token_val> ExpressionList
%type <token_val> additionalExpressions
%type <token_val> Expression
%type <token_val> PrimaryExpression
%type <token_val> MacroDefinition
%type <token_val> MacroDefStatement
%type <token_val> IdentifierList
%type <token_val> additionalIdentifiers
%type <token_val> MacroDefExpression
%type <token_val> Identifier
%type <token_val> Integer

%start Goal

%%

Goal : MacroDefinitionStar MainClass TypeDeclarationStar /*EOF*/ {
																printf("%s",$2);
															 }

MacroDefinitionStar : MacroDefinition MacroDefinitionStar
					|   { $$ = "";}

TypeDeclarationStar : TypeDeclaration TypeDeclarationStar
					|   { $$ = "";}

MainClass : CLASS Identifier LCURL PUBLIC STATIC VOID MAIN LPAR STRING LBRAC RBRAC Identifier RPAR LCURL PRINT LPAR Expression RPAR SEMICOLON RCURL RCURL
			{
				$$ = "class" + $2 + "{ public static void main( String []" + $12 + "){ System.out.println(" + $17 + ");}}";
				printf("%s\n", $$);
			}

TypeDeclaration : CLASS Identifier ClassBody
				| CLASS Identifier EXTENDS Identifier ClassBody

ClassBody : LCURL TypeIdStar MethodDeclarationStar RCURL

TypeIdStar : Type Identifier SEMICOLON TypeIdStar
		   |   { $$ = "";}

MethodDeclarationStar : MethodDeclaration MethodDeclarationStar
					  |   { $$ = "";}

MethodDeclaration : PUBLIC Type Identifier Arguments LCURL TypeIdStar StatementStar RETURN Expression SEMICOLON RCURL

StatementStar : Statement StatementStar
			  |   { $$ = "";}

Arguments : Type Identifier additionalArguments Arguments
		  | Type Identifier additionalArguments

additionalArguments : COMMA Type Identifier
					|   { $$ = "";}


Type : INT LBRAC RBRAC
	 | BOOLEAN
	 | INT
	 | Identifier

Statement : LCURL StatementStar RCURL
		  | PRINT LPAR Expression RPAR SEMICOLON
		  | Identifier EQUAL Expression SEMICOLON
		  | Identifier LBRAC Expression RBRAC EQUAL Expression SEMICOLON
		  | IF LPAR Expression RPAR Statement
		  | IF LPAR Expression RPAR Statement ELSE Statement
		  | WHILE LPAR Expression RPAR Statement
		  | Identifier LPAR ExpressionList RPAR SEMICOLON

ExpressionList : Expression additionalExpressions ExpressionList { $$ = $1 + $2 + $3;}
			   | Expression additionalExpressions { $$ = $1 + $2;}

additionalExpressions : COMMA Expression additionalExpressions { $$ = "," + $2 + $3;}
					  |   { $$ = "";}

Expression : PrimaryExpression AND PrimaryExpression { $$ = $1 + "&&" + $3;}
		   | PrimaryExpression OR PrimaryExpression { $$ = $1 + "||" + $3;}
		   | PrimaryExpression NEQUAL PrimaryExpression { $$ = $1 + "!=" + $3;}
		   | PrimaryExpression LEQUAL PrimaryExpression { $$ = $1 + "<=" + $3;}
		   | PrimaryExpression PLUS PrimaryExpression { $$ = $1 + "+" + $3;}
		   | PrimaryExpression SUB PrimaryExpression { $$ = $1 + "-" + $3;}
		   | PrimaryExpression MULT PrimaryExpression { $$ = $1 + "*" + $3;}
		   | PrimaryExpression DIV PrimaryExpression { $$ = $1 + "/" + $3;}
		   | PrimaryExpression LBRAC PrimaryExpression RBRAC { $$ = $1 + "(" + $3 + ")";}
		   | PrimaryExpression DOTLENGTH { 
											char* temp = (char*) malloc(sizeof(char)*100);
											strcpy(temp,$1);
											strcat(temp,".length");
		   									strcpy($$,temp);
		   								}
		   | PrimaryExpression { $$ = $1;}
		   | PrimaryExpression DOT Identifier LPAR ExpressionList RPAR { $$ = $1 + "." + $3 + "(" + $5 + ")";}
		   | Identifier LPAR ExpressionList RPAR { $$ = $1 + "(" + $3 + ")";}

PrimaryExpression : Integer { $$ = $1;}
				  | BOOLVAL { $$ = $1;}
				  | Identifier { $$ = $1;}
				  | THIS { $$ = "this";}
				  | NEW INT LBRAC Expression RBRAC { $$ = "new int [" + $4 + "]";}
				  | NEW Identifier LPAR RPAR { $$ = "new" + $2 + "()";}
				  | NOT Expression { 	
				  						char* temp = (char*) malloc(sizeof(char)*100);
										strcpy(temp,".");
										strcat(temp,$2);
	   									strcpy($$,temp);
   								   }
				  | LPAR Expression RPAR {$$ = "(" + $2 + ")";}

MacroDefinition : MacroDefExpression
			  	| MacroDefStatement

MacroDefStatement : HASHDEF Identifier LPAR IdentifierList RPAR LCURL StatementStar RCURL

IdentifierList : Identifier additionalIdentifiers IdentifierList
			   | Identifier additionalIdentifiers

additionalIdentifiers : COMMA Identifier additionalIdentifiers
					  |   { $$ = "";}

MacroDefExpression : HASHDEF Identifier LPAR IdentifierList RPAR LPAR Expression RPAR

Identifier : ID {
					$$ = $1;
				}

Integer : INTEGER { $$ = (char*)$1;}

%%

void print(int sum) {
	printf("%d\n",sum);
}
