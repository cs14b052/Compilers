/* BISON FILE P1.y */

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
extern int yylex();
extern void yyerror(char *);
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

MacroArguments* createArgumentNodes(char*);
char* parseValue(MacroArguments*, MacroArguments*,char*);
char* macroEvaluation(char*, char*);
char* substituteValue(MacroArguments* ,MacroArguments* ,char* );
void checkValidityOfExpr(MacroArguments*,MacroArguments*);
Macros* MacroHead = NULL;
Macros* MacroTop = NULL;
int numberOfMacros = 0;
bool macroFound = false;
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
	if (strcmp($8," ") == 0)
		stringConcat($$,"\n");
	stringConcat($$,$9);
	if (strcmp($9," ") == 0)
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
						stringConcat($$," ");
						stringConcat($$,$4);
					}
					|   { $$ = "";}

Type : INT LBRAC RBRAC 
	  { 
	 	$$ = malloc(sizeof(char)*N);
	  	strcpy($$,"int[]");
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
		  | Identifier LPAR ExpressionList RPAR SEMICOLON
		  {
			   	$$ = (char*)malloc(sizeof(char)*N);
			  	strcpy($$,"");
			  	if (macroEvaluation($1,$3) == NULL)
			  	{
			  		stringConcat($$,$1);
			  		stringConcat($$,"(");
			  		stringConcat($$,$3);
			  		stringConcat($$,");\n");
			  	}
			  	else
			  		stringConcat($$,macroEvaluation($1,$3));
		  }
		  | Identifier EQUAL Expression SEMICOLON
			{
				$$ = (char*)malloc(sizeof(char)*N);
			  	strcpy($$,"");
			  	stringConcat($$,$1);
			  	stringConcat($$," = ");
			  	stringConcat($$,$3);
			  	stringConcat($$,";\n");
			}
			| Identifier LBRAC Expression RBRAC EQUAL Expression SEMICOLON
		   {
			   	$$ = (char*)malloc(sizeof(char)*N);
			  	strcpy($$,"");
			  	stringConcat($$,$1);
			  	stringConcat($$,"[");
			  	stringConcat($$,$3);
			  	stringConcat($$,"] = ");
			  	stringConcat($$,$6);
			  	stringConcat($$,";\n");
		   }


elseStatement : ELSE Statement
				{
					$$ = (char*)malloc(sizeof(char)*N);
		  			strcpy($$,"");
		  			stringConcat($$,"else ");
		  			stringConcat($$,$2);
				}
			  |   {$$ = "";}

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
		   		if (macroEvaluation($1,$3) == NULL)
			  	{
			  		stringConcat($$,$1);
			  		stringConcat($$,"(");
			  		stringConcat($$,$3);
			  		stringConcat($$,")");
			  	}
			  	else
			  		stringConcat($$,macroEvaluation($1,$3));
		   }

PrimaryExpression : Integer 
					{ 
						$$ = (char*)malloc(sizeof(char)*N);
						strcpy($$,$1);
					}
				  | TRUE 
				  { 
					$$ = (char*)malloc(sizeof(char)*N);
				  	strcpy($$,"true");
				  }
				  | FALSE 
				  { 
					$$ = (char*)malloc(sizeof(char)*N);
				  	strcpy($$,"false");
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

MacroDefinition : Define Identifier LPAR IdentifierList RPAR ExprState
				{
					MacroTop->MacroIdentifier = (char*)malloc(sizeof(char*)*N);
					MacroTop->nextMacro = NULL;
					char* temp = (char*)malloc(sizeof(char)*N);
					strncpy(temp,$2+1,strlen($2)-2);
					strcpy(MacroTop->MacroIdentifier,temp);
					numberOfMacros++;
					macroFound = false;
				}
Define : HASHDEF
		{
			macroFound = true;
			if (MacroHead == NULL)
			{
				MacroHead = (Macros*) malloc(sizeof(Macros));
				MacroTop = (Macros*) malloc(sizeof(Macros));
				MacroTop = MacroHead;
			}
			else
			{
				Macros* node = (Macros*) malloc(sizeof(Macros));
				MacroTop->nextMacro = (Macros*) malloc(sizeof(Macros));
				MacroTop->nextMacro = node;
				MacroTop = node;
			}
		}

ExprState : LCURL StatementStar RCURL
			{
				$$ = (char*)malloc(sizeof(char)*N);
				strcpy($$,"");
				stringConcat($$,$2);
				MacroTop->MacroValue = (char*)malloc(sizeof(char)*N);
				strcpy(MacroTop->MacroValue,$$);
			}
		  | LPAR Expression RPAR
		  {
			$$ = (char*)malloc(sizeof(char)*N);
			strcpy($$,"");
			stringConcat($$,"(");
			stringConcat($$,$2);
			stringConcat($$,")");
			MacroTop->MacroValue = (char*)malloc(sizeof(char)*N);
			strcpy(MacroTop->MacroValue,$$);
		  }

IdentifierList : Identifier additionalIdentifiers 
				{
					$$ = (char*)malloc(sizeof(char)*N);
					strcpy($$,"");
					stringConcat($$,$1);
					stringConcat($$,$2);
					MacroTop->argumentList = (MacroArguments*)malloc(sizeof(MacroArguments));
					MacroTop->argumentList = createArgumentNodes($$);
				}
			   |  {$$="";}

additionalIdentifiers : additionalIdentifiers COMMA Identifier
						{
							$$ = (char*)malloc(sizeof(char)*N);
							strcpy($$,"");
							stringConcat($$,$1);
							stringConcat($$,",");
							stringConcat($$,$3);
						}
					  |   { $$ = "";}
Identifier : ID {
					$$ = (char*) malloc(sizeof(char)*N);
					strcpy($$,"");
					if (macroFound)
						stringConcat($$,"?");
					stringConcat($$,$1);
					if (macroFound)
						stringConcat($$,"?");
				}

Integer : INTEGER 

%%

void stringConcat(char* a, char* b)
{
	char* temp = (char*) malloc(sizeof(char)*N);
	strcpy(temp,a);
	strcat(temp,b);
	strcpy(a,temp);
	free(temp);
}

MacroArguments* createArgumentNodes(char* id)
{
	int i;
	bool first = true;
	MacroArguments* head  = (MacroArguments*) malloc(sizeof(MacroArguments));
	MacroArguments* argTop  = (MacroArguments*) malloc(sizeof(MacroArguments));
	int prevIndex = 0;
	for (i = 0; i < strlen(id); ++i)
	{
		if (id[i] == ',' || i == strlen(id)-1)
		{
			if (i == strlen(id)-1)
				i++;
			MacroArguments* node  = (MacroArguments*) malloc(sizeof(MacroArguments));
			node->arg = (char*)malloc(sizeof(char)*N);
			strncpy(node->arg,id+prevIndex,i-prevIndex);
			node->nextArg = NULL;
			prevIndex = i+1;
			if (first)
			{
				argTop = node;
				head = argTop;
				first = false;
			}
			else
			{
				argTop->nextArg = (MacroArguments*)malloc(sizeof(MacroArguments));
				argTop->nextArg = node;
				argTop = node;
			}
		}
	}
	if (first)
		head = NULL;

	return head;
}

char* parseValue(MacroArguments* arguments, MacroArguments* values,char* expression)
{
	int i = 0;
	char* changedExpression = (char*)malloc(sizeof(char)*N);
	strcpy(changedExpression,"");
	int prevIndex = 0;
	int lastChar = 0;
	while (i < strlen(expression))
	{
		if (expression[i] == '?')
		{
			int j = i+1;
			strncat(changedExpression,expression+prevIndex,i-prevIndex);
			prevIndex = i+1;
			while(expression[j] != '?')
				j++;
			char* checkValueExpr = (char*)malloc(sizeof(char)*N);
			strncpy(checkValueExpr,expression+prevIndex,j-prevIndex);
			strcat(changedExpression,substituteValue(arguments,values,checkValueExpr));
			i = j+1;
			prevIndex = i;
			lastChar = i;
		}
		else
			i++;
	}
	if (lastChar != i)
		strncat(changedExpression,expression+lastChar,i-lastChar);

	return changedExpression;
}

char* macroEvaluation(char* identifier, char* expressionList)
{
	Macros* temp = (Macros*)malloc(sizeof(Macros));
	temp = MacroHead;
	while (temp!=NULL)
	{
		if (strcmp(temp->MacroIdentifier,identifier)==0)
		{
			MacroArguments* valuesList = (MacroArguments*) malloc(sizeof(MacroArguments));
			valuesList = createArgumentNodes(expressionList);
			checkValidityOfExpr(temp->argumentList,valuesList);
			return parseValue(temp->argumentList,valuesList,temp->MacroValue);
		}
		temp = temp->nextMacro;
	}
	return NULL;
}

void checkValidityOfExpr(MacroArguments* arguments,MacroArguments* values)
{
	MacroArguments* tempArg = (MacroArguments*)malloc(sizeof(MacroArguments));
	MacroArguments* tempVal = (MacroArguments*)malloc(sizeof(MacroArguments));
	tempArg = arguments;
	tempVal = values;

	while(tempArg!=NULL && tempVal!=NULL)
	{
		tempArg = tempArg->nextArg;
		tempVal = tempVal->nextArg;
	}
	if (tempArg != NULL || tempVal != NULL)
	{
		yyparse();
		exit(0);
	}
}

char* substituteValue(MacroArguments* arguments,MacroArguments* values,char* expression)
{
	MacroArguments* tempArg = (MacroArguments*)malloc(sizeof(MacroArguments));
	MacroArguments* tempVal = (MacroArguments*)malloc(sizeof(MacroArguments));
	tempArg = arguments;
	tempVal = values;
	int count = 0;
	while(tempArg!=NULL && tempVal!=NULL)
	{
		count++;
		char* temp = (char*)malloc(sizeof(char)*N);
		strncpy(temp,tempArg->arg+1,strlen(tempArg->arg)-2);

		if (strcmp(temp,expression) == 0)
			return tempVal->arg;

		tempArg = tempArg->nextArg;
		tempVal = tempVal->nextArg;
	}
	return expression;
}