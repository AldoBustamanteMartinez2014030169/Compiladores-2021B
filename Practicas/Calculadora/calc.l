%{
#include "calc.tab.h"
%}

white [ \t]+
digit [0-9]
integer {digit}+
exponent [eE][+-]?{integer}
real {integer}("."{integer})?{exponent}?

%%

{white} { }
{real} { printf("Veo un numero\n"); yylval.NUMERO=atof(yytext); return NUMERO; }

"+" return MAS;
"-" return MENOS;
"*" return POR;
"/" return ENTRE;
"^" return POTENCIA;
"(" return IZQ;
")" return DER;
"==" return IGUALQUE;
">" return MAYORQUE;
"<" return MENORQUE;
"\n" return ENTER;
