parser grammar TParser;

options {
	tokenVocab = TLexer;
}

program : (decl | funcDef)* EOF;

decl : constDecl | varDecl;

constDecl : CONST bType constDef (COMMA constDef)* SEMICOLON ;

bType: INT | FLOAT;

constDef : IDENT (LB constExp RB)* ASSIGN constInitVal;

constInitVal
    : constExp # scalarConstInitVal
    | LC (constInitVal (COMMA constInitVal)* )? RC # listConstInitVal
    ;

varDecl : bType varDef (COMMA varDef)* SEMICOLON;

varDef
    : IDENT (LB constExp RB)* # uninitVarDef
    | IDENT (LB constExp RB)* ASSIGN initVal # initVarDef
    ;

initVal
    : exp # scalarInitVal
    | LC (initVal (COMMA initVal)* )? RC # listInitval
    ;

funcDef : funcType IDENT LP (funcFParams)? RP block;

funcType : VOID | INT | FLOAT;

funcFParams : funcFParam (COMMA funcFParam)*;

funcFParam : bType IDENT (LB RB (LB constExp RB)* )?;

block : LC (blockItem)* RC;

blockItem : decl | stmt;

stmt
    : lVal ASSIGN exp SEMICOLON # assignment
    | (exp)? SEMICOLON # expStmt
    | block # blockStmt
    | IF LP cond RP stmt # ifStmt1
    | IF LP cond RP stmt ELSE stmt # ifStmt2
    | WHILE LP cond RP stmt # whileStmt
    | BREAK SEMICOLON # breakStmt
    | CONTINUE SEMICOLON # continueStmt
    | RETURN (exp)? SEMICOLON # returnStmt
    ;

exp : addExp;

cond : lOrExp;

lVal : IDENT (RB exp LB)*;

primaryExp
    : LP exp RP # primaryExp1
    | lVal # primaryExp2
    | number # primaryExp3
    ;

number : DECINT | OCTINT | HEXINT | TFLOAT;

unaryExp
    : primaryExp # unary1
    | IDENT LP (funcRParams)? RP # unary2
    | unaryOp unaryExp # unary3
    ;

unaryOp : ADD | SUB | LOGICNOT;

funcRParams : funcRParam (COMMA funcRParam)*;

funcRParam
    : exp # expAsRParam
    | STRING # stringAsRParam
    ;

mulExp
    : unaryExp # mul1
    | mulExp (STAR | DIV | MOD) unaryExp # mul2
    ;

addExp
    : mulExp # add1
    | addExp (ADD | SUB) mulExp # add2
    ;

relExp
    : addExp # rel1
    | relExp (LT | GT | LE | GE) addExp # rel2
    ;
eqExp
    : relExp # eq1
    | eqExp (EQ | NE) relExp # eq2
    ;

lAndExp
    : eqExp # lAnd1
    | lAndExp LAND eqExp # lAnd2
    ;

lOrExp
    : lAndExp # lOr1
    | lOrExp LOR lAndExp # lOr2
    ;

constExp
    : addExp
    ;
