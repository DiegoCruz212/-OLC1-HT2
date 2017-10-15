%{
#include <iostream>
#include "lexico.h"

extern int yylineno;
extern char *yytext;
extern int yyfila;
extern int yycolumna;

using namespace std;

int yyerror(const char* men)
{
    string output = yytext;
    cout<<"Error sintactico "<<output<<" linea "<<yylineno<<" columna "<<yycolumna<<endl;
    return 0;
}

%union{
    int entero;
    char cad [256];
    Nodo *nodo;
}

%}