use ordered_float::OrderedFloat;

//  CompUnit → [ CompUnit ] ( Decl | FuncDef )
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct CompUnits(Vec<CompUnit>);

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum CompUnit {
    Decl(Decl),
    FuncDef(FuncDef)
}

// Decl → ConstDecl | VarDecl
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Decl {
    ConstDecl(ConstDecl),
    VarDecl(VarDecl),
}

// ConstDecl → 'const' BType ConstDef { ',' ConstDef } ';'
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct ConstDecl {
    btype: BType,
    const_defs: Vec<ConstDef>
}

// BType → 'int' | 'float'
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum BType {
    INT,
    FLOAT
}

// ConstDef → Ident { '[' ConstExp ']' } '=' ConstInitVal
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct ConstDef {
    ident: Ident,
    const_exp: Option<ConstExp>,
    value: ConstInitVal
}

// ConstInitVal → ConstExp | '{' [ ConstInitVal { ',' ConstInitVal } ] '}'
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum ConstInitVal {
    ConstExp(ConstExp),
    EmptyArrayConstInitVal,
    ArrayConstInitVal(Vec<ConstInitVal>)
}

// VarDecl → BType VarDef { ',' VarDef } ';'
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct VarDecl {
    btype: BType,
    var_defs: Vec<VarDef>
}

// VarDef → Ident { '[' ConstExp ']' }| Ident { '[' ConstExp ']' } '=' InitVal
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct VarDef {
    ident: Ident,
    const_exp: Option<ConstExp>,
    value: Option<InitVal>
}

// InitVal → Exp | '{' [ InitVal { ',' InitVal } ] '}'
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum InitVal {
    Exp(Exp),
    EmptyArrayInitVal,
    ArrayInitVal(Vec<InitVal>)
}


// FuncDef → FuncType Ident '(' [FuncFParams] ')' Block
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct FuncDef {
    func_type: FuncType,
    ident: Ident,
    func_fparams: Option<FuncFParams>,
    block: Block
}

// FuncType → 'void' | 'int' | 'float'
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum FuncType {
    VOID,
    BType(BType)
}

// FuncFParams → FuncFParam { ',' FuncFParam }
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct FuncFParams(Vec<FuncFParam>);

// FuncFParam → BType Ident ['[' ']' { '[' Exp ']' }]
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct FuncFParam {
    btype: BType,
    ident: Ident,
    array_dim: Option<Vec<Exp>>
}

// Block → '{' { BlockItem } '}'
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Block(Vec<BlockItem>);

// BlockItem → Decl | Stmt
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum BlockItem {
    Decl(Decl),
    Stmt(Stmt)
}

// Stmt → LVal '=' Exp ';' | [Exp] ';' | Block
//         | 'if' '( Cond ')' Stmt [ 'else' Stmt ]
//         | 'while' '(' Cond ')' Stmt
//         | 'break' ';' | 'continue' ';'
//         | 'return' [Exp] ';'
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Stmt {
    Assign(LVal, Exp),
    ExpStmt(Option<Exp>),
    Block(Block),
    If(Cond, Box<Stmt>, Option<Box<Stmt>>),
    While(Cond, Box<Stmt>),
    Break,
    Continue,
    Return(Option<Exp>)
}

// Exp → AddExp 
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Exp(AddExp);

// Cond → LOrExp
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Cond(LOrExp);

// LVal → Ident {'[' Exp ']'}
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct LVal {
    ident: Ident,
    exp: Option<Exp>
}

// PrimaryExp → '(' Exp ')' | LVal | Number
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum PrimaryExp {
    Exp(Exp),
    LVal(LVal),
    Number(Number)
}

// Number → IntConst | floatConst
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Number {
    IntConst(i64),
    FloatConst(OrderedFloat<f64>)
}

// UnaryExp → PrimaryExp | Ident '(' [FuncRParams] ')' | UnaryOp UnaryExp
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum UnaryExp {
    PrimaryExp(Box<PrimaryExp>),
    FuncCall(Ident, Option<FuncRParams>),
    UnaryOpExp(UnaryOp, Box<UnaryExp>)
}

// UnaryOp → '+' | '−' | '!' 
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum UnaryOp {
    PLUS,
    MINUS,
    NOT
}

// FuncRParams → Exp { ',' Exp }
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct FuncRParams(Vec<Exp>);

// MulExp → UnaryExp | MulExp ('*' | '/' | '%') UnaryExp
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum MulExp {
    UnaryExp(UnaryExp),
    MulOpExp(Box<MulExp>, MulOp, UnaryExp)
}

#[derive(Debug, Clone, PartialEq, Eq)]
enum MulOp {
    MUL,
    DIV,
    MOD
}

// AddExp → MulExp | AddExp ('+' | '−') MulExp
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum AddExp {
    MulExp(MulExp),
    AddOpExp(Box<AddExp>, AddOp, MulExp)
}


#[derive(Debug, Clone, PartialEq, Eq)]
enum AddOp {
    PLUS,
    MINUS
}

// RelExp → AddExp | RelExp ('<' | '>' | '<=' | '>=') AddExp
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum RelExp {
    AddExp(AddExp),
    RelOpExp(Box<RelExp>, RelOp, AddExp)
}

#[derive(Debug, Clone, PartialEq, Eq)]
enum RelOp {
    LT,
    GT,
    LE,
    GE
}

// EqExp → RelExp | EqExp ('==' | '!=') RelExp
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum EqExp {
    RelExp(RelExp),
    EqOpExp(Box<EqExp>, EqOp, RelExp)
}

#[derive(Debug, Clone, PartialEq, Eq)]
enum EqOp {
    EQ,
    NE
}

// LAndExp → EqExp | LAndExp '&&' EqExp
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum LAndExp {
    EqExp(EqExp),
    LAndOpExp(Box<LAndExp>, EqExp)
}

// LOrExp → LAndExp | LOrExp '||' LAndExp
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum LOrExp {
    LAndExp(LAndExp),
    LOrOpExp(Box<LOrExp>, LAndExp)
}

// ConstExp → AddExp
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct ConstExp(AddExp);

pub type Ident = String;

