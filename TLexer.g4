lexer grammar TLexer;

// These are all supported lexer sections:

// Lexer file header. Appears at the top of h + cpp files. Use e.g. for copyrights.
@lexer::header {/* lexer header section */}

// Appears before any #include in h + cpp files.
@lexer::preinclude {/* lexer precinclude section */}

// Follows directly after the standard #includes in h + cpp files.
@lexer::postinclude {
/* lexer postinclude section */
#ifndef _WIN32
#pragma GCC diagnostic ignored "-Wunused-parameter"
#endif
}

// Directly preceds the lexer class declaration in the h file (e.g. for additional types etc.).
@lexer::context {/* lexer context section */}

// Appears in the public part of the lexer in the h file.
@lexer::members {/* public lexer declarations section */
bool canTestFoo() { return true; }
bool isItFoo() { return true; }
bool isItBar() { return true; }

void myFooLexerAction() { /* do something*/ };
void myBarLexerAction() { /* do something*/ };
}

// Appears in the private part of the lexer in the h file.
@lexer::declarations {/* private lexer declarations/members section */}

// Appears in line with the other class member definitions in the cpp file.
@lexer::definitions {/* lexer definitions section */}

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
