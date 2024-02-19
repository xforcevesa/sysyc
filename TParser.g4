parser grammar TParser;

options {
	tokenVocab = TLexer;
}

program     : (globalexpr | funcdef)+ EOF
            ;

globalexpr  : decl SEMICOLON
            ;

expr        : addexpr
            ;

cond        : lorexpr
            ;

lval        : IDENT (LB expr RB)*
            ;

primaryexpr : LP expr RP
            | number
            | lval
            ;

unaryexpr   : primaryexpr
            | IDENT LP funcrparams* RP
            | (ADD | SUB | LOGICNOT) unaryexpr
            ;

mulexpr     : unaryexpr
            | mulexpr (STAR | DIV | MOD) unaryexpr
            ;

addexpr     : mulexpr
            | addexpr (ADD | SUB) mulexpr
            ;

relexpr     : addexpr
            | relexpr (GT | LT | GE | LE) addexpr
            ;

eqexpr      : relexpr
            | eqexpr (EQ | NE) relexpr
            ;

landexpr    : eqexpr
            | landexpr LAND eqexpr
            ;

lorexpr     : landexpr
            | lorexpr LOR landexpr
            ;

constexpr   : addexpr
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

