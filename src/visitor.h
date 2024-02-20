#pragma once

#include "TParserBaseVisitor.h"

#define DEBUG

using SysycFrontend::TParser;

namespace SysycFrontend {
    class ParseTreeVisitor final : public TParserBaseVisitor {

        virtual std::any visitChildren(antlr4::tree::ParseTree *node);

        std::any visitProgram(TParser::ProgramContext *ctx) override;

        std::any visitGlobalexpr(TParser::GlobalexprContext *ctx) override;

        std::any visitConstexpr(TParser::ConstexprContext *ctx) override;

        std::any visitExpr(TParser::ExprContext *ctx) override;

        std::any visitCond(TParser::CondContext *ctx) override;

        std::any visitLval(TParser::LvalContext *ctx) override;

        std::any visitFuncrparams(TParser::FuncrparamsContext *ctx) override;

        std::any visitBtype(TParser::BtypeContext *ctx) override;

        std::any visitFunctype(TParser::FunctypeContext *ctx) override;

        std::any visitConstinitval(TParser::ConstinitvalContext *ctx) override;

        std::any visitConstdef(TParser::ConstdefContext *ctx) override;

        std::any visitConstdecl(TParser::ConstdeclContext *ctx) override;

        std::any visitInitval(TParser::InitvalContext *ctx) override;

        std::any visitVardef(TParser::VardefContext *ctx) override;

        std::any visitVardecl(TParser::VardeclContext *ctx) override;

        std::any visitDecl(TParser::DeclContext *ctx) override;

        std::any visitBlock(TParser::BlockContext *ctx) override;

        std::any visitStmt(TParser::StmtContext *ctx) override;

        std::any visitFuncfparam(TParser::FuncfparamContext *ctx) override;

        std::any visitFuncfparams(TParser::FuncfparamsContext *ctx) override;

        std::any visitFuncdef(TParser::FuncdefContext *ctx) override;
    };
}
