# -OLC1-HT2
Analizador sintactico.

Here is a scanner which recognizes (and discards) C comments while maintaining a count of the current input line.

%x comment
%%
        int line_num = 1;

"/*"         BEGIN(comment);

<comment>[^*\n]*        /* eat anything that's not a '*' */
        
<comment>"*"+[^*/\n]*   /* eat up '*'s not followed by '/'s */
        
<comment>\n             ++line_num;
        
<comment>"*"+"/"        BEGIN(INITIAL);
        
This scanner goes to a bit of trouble to match as much text as possible with each rule. In general, when attempting to write a high-speed scanner try to match as much possible in each rule, as it's a big win.
