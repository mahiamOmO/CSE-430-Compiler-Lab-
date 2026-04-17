%{
#include <stdio.h>
int line_num = 1;
%}

/* C Keywords */
KEYWORD     "auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while"

/* Patterns */
IDENTIFIER  [a-zA-Z_][a-zA-Z0-9_]*
CONSTANT    [0-9]+(\.[0-9]+)?
COMMENT     "//"[^\n]*

%%

\n              { line_num++; }
[ \t\r]+        { /* ignore whitespace */ }

{COMMENT}       { printf("%d\t%s\tcomment\n", line_num, yytext); }

{KEYWORD}       { printf("%d\t%s\tkeyword\n", line_num, yytext); }

{IDENTIFIER}    { printf("%d\t%s\tidentifier\n", line_num, yytext); }

{CONSTANT}      { printf("%d\t%s\tconstant\n", line_num, yytext); }

"("|")"|"{"|"}"|"["|"]"    { printf("%d\t%s\tparenthesis\n", line_num, yytext); }

";"|":"|","     { printf("%d\t%s\tpunctuation\n", line_num, yytext); }

"="             { printf("%d\t%s\tassign_op\n", line_num, yytext); }

">="|"<="|"=="|"!="|">"|"<"    { printf("%d\t%s\tlogical_op\n", line_num, yytext); }

"+"|"-"|"*"|"/" { printf("%d\t%s\tarithmetic_op\n", line_num, yytext); }

.               { printf("%d\t%s\tunknown\n", line_num, yytext); }

%%

int yywrap() {
    return 1;
}

int main() {
    printf("Line\tToken\t\tType\n");
    printf("----\t-----\t\t----\n");
    yylex();
    return 0;
}

