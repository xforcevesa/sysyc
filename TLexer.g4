lexer grammar TLexer;

ASSIGN  : '=';
STAR    : '*';
DIV     : '/';
ADD     : '+';
SUB     : '-';
MOD     : '%';
LOGICNOT: '!';
GT      : '>';
LT      : '<';
COMMA   : ',';
LP      : '(';
RP      : ')';
LB      : '[';
RB      : ']';
LC      : '{';
RC      : '}';
SEMICOLON: ';';
INC     : '++';
DEC     : '--';


EQ      : '==';
LE      : '<=';
GE      : '>=';
NE      : '!=';
LAND    : '&&';
LOR     : '||';

VOID    : 'void';
FLOAT   : 'float';
INT     : 'int';
IF      : 'if';
ELSE    : 'else';
WHILE   : 'while';
BREAK   : 'break';
CONTINUE: 'continue';
RETURN  : 'return';
CONST   : 'const';

DECINT  : [0-9]+;
OCTINT  : '0' [0-7]+;
HEXINT  : '0x' [0-9A-Fa-f]+;
TFLOAT : [0-9]+ '.' [0-9]* | '.' [0-9]+ | [0-9]+ '.' [0-9]* [eE] [+-]? [0-9]+ | '.' [0-9]+ [eE] [+-]? [0-9]+;
IDENT   : [a-zA-Z_][a-zA-Z_0-9]*;
WS      : [ \t\n\r]+ -> skip ;
LINE_COMMENT: '//' ~[\r\n]* -> skip;
COMMENT: '/*' .*? '*/' -> skip;
