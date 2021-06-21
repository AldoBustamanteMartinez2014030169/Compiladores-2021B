%{
#include "tabla.h"
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

[a-z]+ {printf("Veo una variable \n");
		if(!getsym(yytext))
		{
			yylval.VAR=putsym(yytext, VAR);
		}
		else
		{
			yylval.VAR=getsym(yytext);
		}
		return VAR; }
[a-z]+ return FNCT;
"+" return MAS;
"-" return MENOS;
"*" return POR;
"/" return ENTRE;
"^" return POTENCIA;
"(" return IZQ;
")" return DER;
"=" { printf("Veo un igual \n"); return IGUAL;};
"==" return IGUALQUE;
">" return MAYORQUE;
"<" return MENORQUE;
"\n" return ENTER;
