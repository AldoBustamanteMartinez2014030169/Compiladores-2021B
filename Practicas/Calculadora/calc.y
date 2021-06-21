%{
#include <math.h>
#include <stdio.h>
//#define YYSTYPE double
int yyerror (char const *s);
extern int yylex (void);
%}

%define api.value.type union /* Generate YYSTYPE from these types:  */
%token <double> NUMERO
%token MAS MENOS POR ENTRE POTENCIA MAYORQUE MENORQUE IGUALQUE IGUAL
%token IZQ DER
%token ENTER
%type  <double> expresion

%left MAS MENOS
%left POR ENTRE
%left NEG
%right POTENCIA

%define parse.error verbose
%start entrada
%%

entrada: /* empty */;
entrada: entrada linea;

linea: ENTER;
linea: expresion ENTER { printf("Resultado: %f\n", $1); };

//SINTACTICO								SEMANTICO
expresion: NUMERO 							{ $$ = $1; 										};
expresion: expresion MAS expresion 			{ $$ = $1 + $3; printf("%f + %f\n", $1, $3); 	};
expresion: expresion MENOS expresion 		{ $$ = $1 - $3; printf("%f - %f\n", $1, $3); 	};
expresion: expresion POR expresion 			{ $$ = $1 * $3; printf("%f * %f\n", $1, $3); 	};
expresion: expresion ENTRE expresion 		{ $$ = $1 / $3; printf("%f / %f\n", $1, $3); 	};
expresion: MENOS expresion %prec NEG 		{ $$ = -$2; printf("- %f\n", $2); 				};
expresion: expresion POTENCIA expresion 	{ $$ = pow($1, $3); printf("%f ^ %f\n", $1, $3); };
expresion: expresion IGUALQUE expresion		{ if($1 == $3){ $$ = 1; } else{ $$ = 0; } 		};
expresion: expresion MAYORQUE expresion		{ if($1 > $3){ $$ = 1; } else{ $$ = 0; } 		};
expresion: expresion MENORQUE expresion		{ if($1 < $3){ $$ = 1; } else{ $$ = 0; } 		};
expresion: IZQ expresion DER 				{ $$ = $2; };

%%

int yyerror(char const *s) {
	printf("%s\n", s);
  	return 0;
}

int main() {
    int ret = yyparse();
    if (ret){
	fprintf(stderr, "%d error found.\n",ret);
    }

	init_table ();
	
    return 0;
}

