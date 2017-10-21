%{
    using namespace std;

int yyfila = 1;
int yycolumna = 0;

%}

%option noyywrap

Letra			[a-zA-ZñÑ]
numero			[0-9]
entero			{number}+
decimal			({entero}"."{entero})
caracter		[\'][^\'\n][\']
id				{Letra}({Letra}|{number}|_)*

%x SING_COMMENT
%x MULT_COMMENT
%x CADENA

%%

    char strBuff[MAX_STR_CONST];
    char *strBuffPtr;

"<<" {BEGIN(SING_COMMENT);}
<SING_COMMMENT>[^\n] //Descartar todo lo que no sea un salto de linea
<SING_COMMMENT>"\n" {yyfila++; col = 0; BEGIN(INITIAL); }

"<-" {BEGIN(MULT_COMMENT);}
<MULT_COMMENT>[^-]* //Descartar todo lo que no sea un guion (-)
<MULT_COMMENT>"-"+[^->\n]* //Descartar todos los guiones (-) a los que no los siga un ">"
<MULT_COMMENT>"\n" { yyfila++; col = 0; }
<MULT_COMMENT>"-"+">" {BEGIN(INITIAL);}

"\"" { strBuffPtr = strBuff; BEGIN{CADENA}; }
<CADENA>"\"" { 
    col = col + strlen(yyval.cad);
    strcpy(yyval.cad, strBuffPtr);
    strBuffPtr = "\0";
    BEGIN(INITIAL);
    return tkstring;    
             }
<CADENA>"\\n"  { *strBuffPtr++ = '\n'; col++; }
<CADENA>"\\t"  { *strBuffPtr++ = '\t'; col++; }
<CADENA>"\\r"  { *strBuffPtr++ = '\r'; col++; }
<CADENA>"\\b"  { *strBuffPtr++ = '\b'; col++; }
<CADENA>"\\f"  { *strBuffPtr++ = '\f'; col++; }
<CADENA>"\\"(.|\n)  { *strBuffPtrr++ = yytext[1]; col++; }
<CADENA>[^\\\n\"]+  {
        char *yptr = yytext;
        while ( *yptr ){
            *strBuffPtr++ = *yptr++;
        }
                    }