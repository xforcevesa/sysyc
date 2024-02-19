parser grammar TParser;

options {
	tokenVocab = TLexer;
}

program     : (globalexpr | funcdef)+ EOF
            ;

globalexpr  : decl SEMICOLON
            ;


constexpr   : expr
            ;

expr        : primaryexpr
            | IDENT LP funcrparams* RP
            | (ADD | SUB | LOGICNOT) expr
            | expr (STAR | DIV | MOD) expr
            | lval (INC | DEC)
            | expr (ADD | SUB) expr
            | expr (GT | LT | GE | LE) expr
            | expr (EQ | NE) expr
            | expr LAND expr
            | expr LOR expr
            | lval ASSIGN expr
            ;

cond        : expr
            ;

lval        : IDENT (LB expr RB)*
            | (INC | DEC) lval
            ;

primaryexpr : LP expr RP
            | number
            | lval
            ;

funcrparams : expr (COMMA expr)*
            ;

number      : DECINT
            | OCTINT
            | HEXINT
            | TFLOAT
            ;

btype       : INT
            | FLOAT
            ;

functype    : INT
            | FLOAT
            | VOID
            ;

constinitval: constexpr
            | (LB constinitval (COMMA constinitval)* RB)*
            ;

constdef    : IDENT (LB constexpr RB)* ASSIGN constinitval
            ;

constdecl   : CONST btype constdef (COMMA constdef)*
            ;

initval     : expr
            | LC (initval (COMMA initval)*)? RC
            ;
vardef      : IDENT (LB constexpr RB)*
            | IDENT (LB constexpr RB)* ASSIGN initval
            ;
vardecl     : btype vardef (COMMA vardef)*
            ;
decl        : constdecl
            | vardecl
            ;

blockitem   : decl SEMICOLON
            | stmt
            ;

block       : LC blockitem* RC
            ;
stmt        : lval ASSIGN expr SEMICOLON
            | expr SEMICOLON
            | block
            | IF LP cond RP stmt (ELSE stmt)?
            | WHILE LP cond RP stmt
            | BREAK SEMICOLON
            | CONTINUE SEMICOLON
            | RETURN expr SEMICOLON
            ;

funcfparam  : btype IDENT (LB RB (LB expr RB)*)?
            ;

funcfparams : funcfparam (COMMA funcfparam)*
            ;

funcdef     : functype IDENT LP (funcfparams)? RP block
            ;

