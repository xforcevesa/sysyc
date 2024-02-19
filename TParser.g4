parser grammar TParser;

options {
	tokenVocab = TLexer;
}

// These are all supported parser sections:

// Parser file header. Appears at the top in all parser related files. Use e.g. for copyrights.
@parser::header {/* parser/listener/visitor header section */}

// Appears before any #include in h + cpp files.
@parser::preinclude {/* parser precinclude section */}

// Follows directly after the standard #includes in h + cpp files.
@parser::postinclude {
/* parser postinclude section */
#ifndef _WIN32
#pragma GCC diagnostic ignored "-Wunused-parameter"
#endif
}

// Directly preceeds the parser class declaration in the h file (e.g. for additional types etc.).
@parser::context {/* parser context section */}

// Appears in the private part of the parser in the h file.
// The function bodies could also appear in the definitions section, but I want to maximize
// Java compatibility, so we can also create a Java parser from this grammar.
// Still, some tweaking is necessary after the Java file generation (e.g. bool -> boolean).
@parser::members {
/* public parser declarations/members section */
bool myAction() { return true; }
bool doesItBlend() { return true; }
void cleanUp() {}
void doInit() {}
void doAfter() {}
}

// Appears in the public part of the parser in the h file.
@parser::declarations {/* private parser declarations section */}

// Appears in line with the other class member definitions in the cpp file.
@parser::definitions {/* parser definitions section */}

// Additionally there are similar sections for (base)listener and (base)visitor files.
@parser::listenerpreinclude {/* listener preinclude section */}
@parser::listenerpostinclude {/* listener postinclude section */}
@parser::listenerdeclarations {/* listener public declarations/members section */}
@parser::listenermembers {/* listener private declarations/members section */}
@parser::listenerdefinitions {/* listener definitions section */}

@parser::baselistenerpreinclude {/* base listener preinclude section */}
@parser::baselistenerpostinclude {/* base listener postinclude section */}
@parser::baselistenerdeclarations {/* base listener public declarations/members section */}
@parser::baselistenermembers {/* base listener private declarations/members section */}
@parser::baselistenerdefinitions {/* base listener definitions section */}

@parser::visitorpreinclude {/* visitor preinclude section */}
@parser::visitorpostinclude {/* visitor postinclude section */}
@parser::visitordeclarations {/* visitor public declarations/members section */}
@parser::visitormembers {/* visitor private declarations/members section */}
@parser::visitordefinitions {/* visitor definitions section */}

@parser::basevisitorpreinclude {/* base visitor preinclude section */}
@parser::basevisitorpostinclude {/* base visitor postinclude section */}
@parser::basevisitordeclarations {/* base visitor public declarations/members section */}
@parser::basevisitormembers {/* base visitor private declarations/members section */}
@parser::basevisitordefinitions {/* base visitor definitions section */}

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

block       : LCB blockitem* RCB
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

