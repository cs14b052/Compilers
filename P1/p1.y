/* BISON FILE adder.y */

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern int yylex();
extern void yyerror(char *);
void print(int);
void stringConcat(char*, char*);
typedef struct MacroArguments
{
	char* arg;
	struct MacroArguments* nextArg;
}MacroArguments;

typedef struct Macros
{
	char* MacroIdentifier;
	MacroArguments* argumentList;
	char* MacroValue;
	struct Macros *nextMacro;
}Macros;

Macros* MacroHead = NULL;
Macros* MacroTop = NULL;
int numberOfMacros = 0;
#define N 10000
%}

%union {
	char* token_val;
};

%token <token_val>  CLASS PUBLIC STATIC VOID MAIN LBRAC RBRAC STRING PRINT EXTENDS COMMA RETURN THIS NEW NOT HASHDEF INT BOOLEAN IF ELSE WHILE AND OR NEQUAL LEQUAL DOTLENGTH DOT LCURL RCURL PLUS SUB MULT DIV LPAR RPAR EQUAL SEMICOLON ID TRUE FALSE INTEGER

%type <token_val> MainClass
%type <token_val> MacroDefinitionStar
%type <token_val> MacroDefinition
%type <token_val> ExprState
%type <token_val> additionalIdentifiers
%type <token_val> IdentifierList
%type <token_val> TypeDeclarationStar
%type <token_val> TypeDeclaration
%type <token_val> ClassBody
%type <token_val> TypeIdStar
%type <token_val> Type
%type <token_val> MethodDeclarationStar
%type <token_val> MethodDeclaration
%type <token_val> Arguments
%type <token_val> additionalArguments
%type <token_val> StatementStar
%type <token_val> Statement
%type <token_val> additionalExpressions
%type <token_val> Expression
%type <token_val> ExpressionList
%type <token_val> PrimaryExpression
%type <token_val> Identifier
%type <token_val> IdentifierStatement
%type <token_val> Integer
%type <token_val> elseStatement
%type <token_val> Goal

%start Goal

%%


Goal :  MacroDefinitionStar MainClass TypeDeclarationStar
		{
			$$ = (char*)malloc(sizeof(char)*N);
			strcpy($$,"");
			stringConcat($$,$2);
			stringConcat($$,$3);
			printf("%s\n",$$);
		 }

MacroDefinitionStar : MacroDefinition MacroDefinitionStar
					|   { $$ = "";}

MainClass : CLASS Identifier LCURL PUBLIC STATIC VOID MAIN LPAR STRING LBRAC RBRAC Identifier RPAR LCURL PRINT LPAR Expression RPAR SEMICOLON RCURL RCURL
		  {
		  	$$ = (char*)malloc(sizeof(char)*N);
		  	strcpy($$,"");
			stringConcat($$,"class ");
			stringConcat($$,$2);
			stringConcat($$,"{\n public static void main(String[] ");
			stringConcat($$,$12);
			stringConcat($$,"){\n\t System.out.println(");
			stringConcat($$,$17);
			stringConcat($$,");\n}\n}\n");
		  }

TypeDeclarationStar : TypeDeclaration TypeDeclarationStar
					{
						$$ = (char*)malloc(sizeof(char)*N);
						strcpy($$,"");
						stringConcat($$,$1);
						stringConcat($$,$2);
					}
					|   { $$ = "";}

TypeDeclaration : CLASS Identifier ClassBody
			    {
			    	$$ = (char*)malloc(sizeof(char)*N);
			    	strcpy($$,"");
			    	stringConcat($$,"class ");
			    	stringConcat($$,$2);
			    	stringConcat($$,$3);
			    }
				| CLASS Identifier EXTENDS Identifier ClassBody
				{
					$$ = (char*)malloc(sizeof(char)*N);
			    	strcpy($$,"");
			    	stringConcat($$,"class ");
			    	stringConcat($$,$2);
			    	stringConcat($$," extends ");
			    	stringConcat($$,$4);
			    	stringConcat($$,$5);
				}

ClassBody : LCURL TypeIdStar MethodDeclarationStar RCURL
			{
				$$ = (char*)malloc(sizeof(char)*N);	
				strcpy($$,"");
				stringConcat($$,"{\n");
				stringConcat($$,$2);
				stringConcat($$,"\n");
				stringConcat($$,$3);
				stringConcat($$,"\n}\n");
			}

TypeIdStar : TypeIdStar Type Identifier SEMICOLON
			{
				$$ = (char*)malloc(sizeof(char)*N);
				strcpy($$,"");
				stringConcat($$,$1);
				stringConcat($$," ");
				stringConcat($$,$2);
				stringConcat($$," ");
				stringConcat($$,$3);
				stringConcat($$,";\n");
			}
		   |   { $$ = "";}

MethodDeclarationStar : MethodDeclaration MethodDeclarationStar
						{
							$$ = (char*)malloc(sizeof(char)*N);
							strcpy($$,"");
							stringConcat($$,$1);
							stringConcat($$,$2);
						}
					  |   { $$ = "";}
MethodDeclaration : PUBLIC Type Identifier LPAR Arguments RPAR LCURL TypeIdStar StatementStar RETURN Expression SEMICOLON RCURL
{
	$$ = (char*)malloc(sizeof(char)*N);
	strcpy($$,"");
	stringConcat($$,"public ");
	stringConcat($$,$2);
	stringConcat($$," ");
	stringConcat($$,$3);
	stringConcat($$,"(");
	stringConcat($$,$5);
	stringConcat($$,") {\n");
	stringConcat($$,$8);
	if (strcmp($8,"") == 0)
		stringConcat($$,"\n");
	stringConcat($$,$9);
	if (strcmp($9,"") == 0)
		stringConcat($$,"\n");
	stringConcat($$,"return ");
	stringConcat($$,$11);
	stringConcat($$,"; \n}\n");
}

Arguments : Type Identifier additionalArguments
			{
				$$ = (char*)malloc(sizeof(char)*N);
				strcpy($$,"");
				stringConcat($$,$1);
				stringConcat($$," ");
				stringConcat($$,$2);
				stringConcat($$,$3);	
			}
		  |  {$$="";}

additionalArguments : additionalArguments COMMA Type Identifier 
					{
						$$ = (char*)malloc(sizeof(char)*N);
						strcpy($$,"");
						stringConcat($$,$1);
						stringConcat($$,", ");
						stringConcat($$,$3);
						stringConcat($$,$4);
					}
					|   { $$ = "";}

Type : INT LBRAC RBRAC 
	  { 
	 	$$ = malloc(sizeof(char)*N);
	  	strcpy($$,"int []");
	  }
	 | BOOLEAN 
	 { 
	 	$$ = malloc(sizeof(char)*N);
	 	strcpy($$,"boolean ");
	 }
	 | INT {
	 			$$ = malloc(sizeof(char)*N);
	 			strcpy($$,"int "); 
	 		}
	 | Identifier { $$ = malloc(sizeof(char)*(strlen($1)+1));
	 				 strcpy($$,$1);
	 			  }


StatementStar : Statement StatementStar
				{
					$$ = malloc(sizeof(char)*N);
		 			strcpy($$,"");
		 			stringConcat($$,$1);
		 			stringConcat($$,$2);
				}
			  |   { $$ = "";}

Statement : LCURL StatementStar RCURL
			{
				$$ = (char*)malloc(sizeof(char)*N);
				strcpy($$,"");
				stringConcat($$,"{\n");
				stringConcat($$,$2);
				stringConcat($$,"}\n");
			}
		  | PRINT LPAR Expression RPAR SEMICOLON
		  {
		  	$$ = (char*)malloc(sizeof(char)*N);
		  	strcpy($$,"");
		  	stringConcat($$,"System.out.println(");
		  	stringConcat($$,$3);
		  	stringConcat($$,");\n");
		  }
		  | Identifier IdentifierStatement
		  {
		  	$$ = (char*)malloc(sizeof(char)*N);
		  	strcpy($$,"");
		  	stringConcat($$,$1);
		  	stringConcat($$,$2);
		  }
		  | IF LPAR Expression RPAR Statement elseStatement
		  {
		  	$$ = (char*)malloc(sizeof(char)*N);
		  	strcpy($$,"");
		  	stringConcat($$,"if(");
		  	stringConcat($$,$3);
		  	stringConcat($$,")\n");
		  	stringConcat($$,$5);
		  	stringConcat($$,"\n");
		  	stringConcat($$,$6);
		  }
		  | WHILE LPAR Expression RPAR Statement
		  {
		  	$$ = (char*)malloc(sizeof(char)*N);
		  	strcpy($$,"");
		  	stringConcat($$,"while(");
		  	stringConcat($$,$3);
		  	stringConcat($$,")");
		  	stringConcat($$,$5);
		  }

IdentifierStatement: EQUAL Expression SEMICOLON
					{
						$$ = (char*)malloc(sizeof(char)*N);
					  	strcpy($$,"");
					  	stringConcat($$," = ");
					  	stringConcat($$,$2);
					  	stringConcat($$,";\n");
					}
				   | LBRAC Expression RBRAC EQUAL Expression SEMICOLON
				   {
					   	$$ = (char*)malloc(sizeof(char)*N);
					  	strcpy($$,"");
					  	stringConcat($$,"[");
					  	stringConcat($$,$2);
					  	stringConcat($$,"] = ");
					  	stringConcat($$,$5);
					  	stringConcat($$,";\n");
				   }
				   | LPAR ExpressionList RPAR SEMICOLON
				   {
					   	$$ = (char*)malloc(sizeof(char)*N);
					  	strcpy($$,"");
					  	stringConcat($$,"(");
					  	stringConcat($$,$2);
					  	stringConcat($$,");\n");
					}

elseStatement : ELSE Statement
				{
					$$ = (char*)malloc(sizeof(char)*N);
		  			strcpy($$,"");
		  			stringConcat($$,"else ");
		  			stringConcat($$,$2);
				}
			  |  {$$ = "";}

ExpressionList : Expression additionalExpressions
				{
					$$ = (char*)malloc(sizeof(char)*N);
		  			strcpy($$,"");
		  			stringConcat($$,$1);
		  			stringConcat($$,$2);
				}
			   |  { $$ = "";}

additionalExpressions : additionalExpressions COMMA Expression
						{
							$$ = (char*)malloc(sizeof(char)*N);
				  			strcpy($$,"");
				  			stringConcat($$,$1);
				  			stringConcat($$,", ");
				  			stringConcat($$,$3);
						}
					  |    { $$ = "";}

Expression : PrimaryExpression AND PrimaryExpression
			{
				$$ = (char*)malloc(sizeof(char)*N);
		  		strcpy($$,"");
		  		stringConcat($$,$1);
		  		stringConcat($$,"&&");
		  		stringConcat($$,$3);
			}
		   | PrimaryExpression OR PrimaryExpression 
		   {
				$$ = (char*)malloc(sizeof(char)*N);
		  		strcpy($$,"");
		  		stringConcat($$,$1);
		  		stringConcat($$,"||");
		  		stringConcat($$,$3);
			}
		   | PrimaryExpression NEQUAL PrimaryExpression 
		   {
				$$ = (char*)malloc(sizeof(char)*N);
		  		strcpy($$,"");
		  		stringConcat($$,$1);
		  		stringConcat($$,"!=");
		  		stringConcat($$,$3);
			}
		   | PrimaryExpression LEQUAL PrimaryExpression 
		   {
				$$ = (char*)malloc(sizeof(char)*N);
		  		strcpy($$,"");
		  		stringConcat($$,$1);
		  		stringConcat($$,"<=");
		  		stringConcat($$,$3);
			}
		   | PrimaryExpression PLUS PrimaryExpression
		   {
				$$ = (char*)malloc(sizeof(char)*N);
		  		strcpy($$,"");
		  		stringConcat($$,$1);
		  		stringConcat($$,"+");
		  		stringConcat($$,$3);
			}
		   | PrimaryExpression SUB PrimaryExpression 
		   {
				$$ = (char*)malloc(sizeof(char)*N);
		  		strcpy($$,"");
		  		stringConcat($$,$1);
		  		stringConcat($$,"-");
		  		stringConcat($$,$3);
			}
		   | PrimaryExpression MULT PrimaryExpression
		   {
				$$ = (char*)malloc(sizeof(char)*N);
		  		strcpy($$,"");
		  		stringConcat($$,$1);
		  		stringConcat($$,"*");
		  		stringConcat($$,$3);
			}
		   | PrimaryExpression DIV PrimaryExpression 
		   {
				$$ = (char*)malloc(sizeof(char)*N);
		  		strcpy($$,"");
		  		stringConcat($$,$1);
		  		stringConcat($$,"/");
		  		stringConcat($$,$3);
			}
		   | PrimaryExpression LBRAC PrimaryExpression RBRAC 
		   {
				$$ = (char*)malloc(sizeof(char)*N);
		  		strcpy($$,"");
		  		stringConcat($$,$1);
		  		stringConcat($$,"[");
		  		stringConcat($$,$3);
		  		stringConcat($$,"]");
			}
		   | PrimaryExpression DOTLENGTH 
		   {
				$$ = (char*)malloc(sizeof(char)*N);
		  		strcpy($$,"");
		  		stringConcat($$,$1);
		  		stringConcat($$,".length");
			}
		   | PrimaryExpression 
		   {
				$$ = (char*)malloc(sizeof(char)*N);
		  		strcpy($$,$1);
			}
		   | PrimaryExpression DOT Identifier LPAR ExpressionList RPAR 
		   {
				$$ = (char*)malloc(sizeof(char)*N);
		   		strcpy($$,"");
		   		stringConcat($$,$1);
				stringConcat($$,".");
				stringConcat($$,$3);
				stringConcat($$,"(");
				stringConcat($$,$5);
				stringConcat($$,")");
		   }
		   | Identifier LPAR ExpressionList RPAR
		   {
				$$ = (char*)malloc(sizeof(char)*N);
				strcpy($$,"");
				int i = 0;
				for(i = 0;i < numberOfMacros;i++)
				{
					if(strcmp(Macros[i],$1)==0)
					{
						strcpy($$,MacroExpr[i]);
						break;
					}
				}
			}

PrimaryExpression : Integer 
					{ 
						$$ = (char*)malloc(sizeof(char)*N);
						strcpy($$,$1);
					}
				  | TRUE 
				  { 
					$$ = (char*)malloc(sizeof(char)*N);
				  	strcpy($$,"true ");
				  }
				  | FALSE 
				  { 
					$$ = (char*)malloc(sizeof(char)*N);
				  	strcpy($$,"false ");
				  }
				  | Identifier 
				  { 
					$$ = (char*)malloc(sizeof(char)*N);
				  	strcpy($$,$1);
				  }
				  | THIS 
				  { 
					$$ = (char*)malloc(sizeof(char)*N);
				  	strcpy($$,"this");
				  }
				  | NEW INT LBRAC Expression RBRAC
				  {
					$$ = (char*)malloc(sizeof(char)*N);
				  	strcpy($$,"new int[");
				  	stringConcat($$,$4);
				  	stringConcat($$,"]");
				  }
				  | NEW Identifier LPAR RPAR
				  {
					$$ = (char*)malloc(sizeof(char)*N);
				  	strcpy($$,"");
				  	stringConcat($$,"new ");
				  	stringConcat($$,$2);
				  	stringConcat($$,"()");
				  }
				  | NOT Expression 
				  {
					$$ = (char*)malloc(sizeof(char)*N);
				  	strcpy($$,"!");
				  	stringConcat($$,$2);
				  }
				  | LPAR Expression RPAR
				  {
					$$ = (char*)malloc(sizeof(char)*N);
				  	strcpy($$,"");
				  	stringConcat($$,"(");
				  	stringConcat($$,$2);
				  	stringConcat($$,")");
				  }

MacroDefinition : HASHDEF Identifier LPAR IdentifierList RPAR ExprState
				{
					Macros[numberOfMacros] = (char*)malloc(sizeof(char*)*N);
					MacroExpr[numberOfMacros] = (char*)malloc(sizeof(char*)*N);
					strcpy(Macros[numberOfMacros],$2);
					strcpy(MacroExpr[numberOfMacros],$6);
					numberOfMacros++;
				}
// Define : HASHDEF
// 		{
// 			if (MacroHead == NULL)
// 			{
// 				MacroHead = (Macros*) malloc(sizeof(Macros));
// 				MacroTop = MacroHead;
// 			}
// 			else
// 			{
// 				Macros* node = (Macros*) malloc(sizeof(Macros));
// 				MacroHead->nextMacro = node;
// 				MacroTop = node;
// 			}
// 		}

ExprState : LCURL StatementStar RCURL
			{
				$$ = (char*)malloc(sizeof(char)*N);
				strcpy($$,"");
				stringConcat($$,$2);
			}
		  | LPAR Expression RPAR
		  {
			$$ = (char*)malloc(sizeof(char)*N);
			strcpy($$,"");
			stringConcat($$,"(");
			stringConcat($$,$2);
			stringConcat($$,")");
		  }

IdentifierList : Identifier additionalIdentifiers 
			   |  {$$="";}

additionalIdentifiers : additionalIdentifiers COMMA Identifier
					  |   { $$ = "";}
Identifier : ID {
					$$ = (char*) malloc(sizeof(char)*N);
					strcpy($$,"");
					stringConcat($$,$1);
				}

Integer : INTEGER 

%%

void print(int sum) 
{
	printf("%d\n",sum);
}

void stringConcat(char* a, char* b)
{
	char* temp = (char*) malloc(sizeof(char)*N);
	strcpy(temp,a);
	strcat(temp,b);
	strcpy(a,temp);
	free(temp);
}