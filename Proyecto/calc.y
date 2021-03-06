%{
#include <math.h>
#include <stdio.h>
#include "tabla.h"
//#define YYSTYPE double
int yyerror (char const *s);
extern int yylex (void);
%}

%define api.value.type union /* Generate YYSTYPE from these types:  */
%token <symrec*> VAR FNCT    /* Symbol table pointer: variable and function.  */
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
expresion: VAR								{ $$ = $1->value.var; printf("Valor de variable: %f\n", $1->value.var);		};
expresion: 
 VAR IGUAL expresion {
                        printf("Intentando asignar \n");
                        $$ = $3;
                        printf("valor: %f\n", $3);
                        $1->value.var = $3;
                        printf("valor: %f\n", $1->value.var);	
                     }
;
expresion: FNCT IZQ expresion DER			{ $$ = (*($1->value.fnctptr))($3); 				};
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

struct init
{
	char const *fname;
	double (*fnct) (double);
};

struct init const arith_fncts[] =
{
{ "atan", atan },
{ "cos",  cos  },
{ "exp",  exp  },
{ "ln",   log  },
{ "sin",  sin  },
{ "sqrt", sqrt },
{ 0, 0 },
};

/* The symbol table: a chain of 'struct symrec'.  */
symrec *sym_table;

/* Put arithmetic functions in table.  */
static
void
init_table (void)
{
	int i;
	for (i = 0; arith_fncts[i].fname != 0; i++)
	{
		symrec *ptr = putsym (arith_fncts[i].fname, FNCT);
		ptr->value.fnctptr = arith_fncts[i].fnct;
	}
}

symrec *
putsym (char const *sym_name, int sym_type)
{
	symrec *ptr = (symrec *) malloc (sizeof (symrec));
	ptr->name = (char *) malloc (strlen (sym_name) + 1);
	strcpy (ptr->name,sym_name);
	ptr->type = sym_type;
	ptr->value.var = 0; /* Set value to 0 even if fctn.  */
	ptr->next = (struct symrec *)sym_table;
	sym_table = ptr;
	return ptr;
}

symrec *
getsym (char const *sym_name)
{
symrec *ptr;
for (ptr = sym_table; ptr != (symrec *) 0;
    ptr = (symrec *)ptr->next)
 if (strcmp (ptr->name, sym_name) == 0)
   return ptr;
return 0;
}

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

