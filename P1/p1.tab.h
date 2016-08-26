/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_P1_TAB_H_INCLUDED
# define YY_YY_P1_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    CLASS = 258,
    PUBLIC = 259,
    STATIC = 260,
    VOID = 261,
    MAIN = 262,
    LBRAC = 263,
    RBRAC = 264,
    STRING = 265,
    PRINT = 266,
    EXTENDS = 267,
    COMMA = 268,
    RETURN = 269,
    THIS = 270,
    NEW = 271,
    NOT = 272,
    HASHDEF = 273,
    INT = 274,
    BOOLEAN = 275,
    IF = 276,
    ELSE = 277,
    WHILE = 278,
    AND = 279,
    OR = 280,
    NEQUAL = 281,
    LEQUAL = 282,
    DOTLENGTH = 283,
    DOT = 284,
    LCURL = 285,
    RCURL = 286,
    PLUS = 287,
    SUB = 288,
    MULT = 289,
    DIV = 290,
    LPAR = 291,
    RPAR = 292,
    EQUAL = 293,
    SEMICOLON = 294,
    ID = 295,
    BOOLVAL = 296,
    INTEGER = 297
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 12 "p1.y" /* yacc.c:1915  */

	int	int_val;
	char* token_val;

#line 102 "p1.tab.h" /* yacc.c:1915  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_P1_TAB_H_INCLUDED  */
