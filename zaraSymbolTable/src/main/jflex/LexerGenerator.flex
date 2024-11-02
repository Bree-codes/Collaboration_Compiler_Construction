package red.stevo.code.Lexer;

import java.lang.System;
import java.io.IOException;
import java_cup.runtime.Symbol;

%%

%class ZaraLexer
%unicode
%public
%type Symbol
%line
%column


%%


// Ignore whitespace
[ \t\n]+                     { /* Ignore whitespace */ }
// Single-line comments
"#".*                        { /* Ignore comments */ }
// Multi-line comments
"/*"([^*]|[*][^/])*"*/"       { /* Ignore multi-line comments */ }

\"([^\"\\\n]|\\[\"\\btnfr])*\" {return new Symbol(sym.STRING_LITERAL, yytext());}


// KEYWORDS

("int" | "float" | "string" | "arr" | "stack") {return new Symbol(sym.DATATYPE, yytext());}

"const"  {return new Symbol(sym.CONST);}
"global"  {return new Symbol(sym.GLOBAL);}
"break"  {return new Symbol(sym.BREAK);}
"in"  {return new Symbol(sym.IN);}
"while"  {return new Symbol(sym.WHILE);}
"if"  {return new Symbol(sym.IF);}
"else"  {return new Symbol(sym.ELSE);}
"else-if"  {return new Symbol(sym.ELSEIF);}
"do"  {return new Symbol(sym.DO);}
"for"  {return new Symbol(sym.FOR);}
"return"  {return new Symbol(sym.RETURN);}
"continue"  {return new Symbol(sym.CONTINUE);}
"class"  {return new Symbol(sym.CLASS);}



// CONSTANTS (integers)
[+-]?[0-9]+                             {
    return new Symbol(sym.CONSTANT, Integer.parseInt(yytext()));
}

// FLOATS
[+-]?[0-9]+(\.[0-9]+)?([eE][+-]?[0-9]+)?  {
    return new Symbol(sym.FLOAT, Double.parseDouble(yytext()));
}

// IDENTIFIERS
[A-Za-z][A-Za-z0-9]*                    {
    return new Symbol(sym.IDENTIFIER, yytext());
}

// OPERATORS
"!="     {return new Symbol(sym.OPERATOR_NOT_EQUAL);}
">"      {return new Symbol(sym.OPERATOR_GREATER);}
"<"      {return new Symbol(sym.OPERATOR_LESS);}
"&&"     {return new Symbol(sym.OPERATOR_AND);}
">="     {return new Symbol(sym.OPERATOR_GREATER_EQUAL);}
"<="     {return new Symbol(sym.OPERATOR_LESS_EQUAL);}
"!"      {return new Symbol(sym.OPERATOR_NOT);}
"||"     {return new Symbol(sym.OPERATOR_OR);}
"."      {return new Symbol(sym.OPERATOR_DOT);}
"=="     {return new Symbol(sym.OPERATOR_EQUAL);}
"+"      {return new Symbol(sym.OPERATOR_ADD);}
"-"      {return new Symbol(sym.OPERATOR_SUB);}
"*"      {return new Symbol(sym.OPERATOR_MUL);}
"/"      {return new Symbol(sym.OPERATOR_DIV);}
"true"   {return new Symbol(sym.TRUE);}
"false"  {return new Symbol(sym.FALSE);}





// PUNCTUATION
"="   {return new Symbol(sym.ASSIGN);}
"("   {return new Symbol(sym.PUNCTUATION_LEFT);}
")"   {return new Symbol(sym.PUNCTUATION_RIGHT);}
";"   {return new Symbol(sym.SEMI_COLON);}
"{"   {return new Symbol(sym.PUNCTUATION_CURLED_LEFT);}
"}"   {return new Symbol(sym.PUNCTUATION_CURLED_RIGHT);}
","   {return new Symbol(sym.PUNCTUATION_COMMA);}
":"   {return new Symbol(sym.PUNCTUATION_COLON);}
"["   {return new Symbol(sym.PUNCTUATION_SQUARE_LEFT);}
"]"   {return new Symbol(sym.PUNCTUATION_SQUARE_RIGHT);}


// Error
.  {
          System.err.println("Error : \n Error on line "+(yyline+1)+"\n Unrecognized character '" + yytext()+"'");
          System.exit(1);
      }

<<EOF>> { return new Symbol( sym.EOF ); }

