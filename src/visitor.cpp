#include "visitor.h"

namespace SysycFrontend {
    std::any ParseTreeVisitor::visitChildren(antlr4::tree::ParseTree *node) {
        // std::cout << node->toString();
        for (const auto item: node->children) {
            std::cout << " : " << item->toString();
        }
        std::cout << std::endl;
        return TParserBaseVisitor::visitChildren(node);
    }


    std::any ParseTreeVisitor::visitBlock(TParser::BlockContext *ctx) {
        std::cout << "In ParseTreeVisitor::" << __FUNCTION__;
        return visitChildren(ctx);
    }

    std::any ParseTreeVisitor::visitBtype(TParser::BtypeContext *ctx) {
        std::cout << "In ParseTreeVisitor::" << __FUNCTION__;
        return visitChildren(ctx);
    }

    std::any ParseTreeVisitor::visitCond(TParser::CondContext *ctx) {
        std::cout << "In ParseTreeVisitor::" << __FUNCTION__;
        return visitChildren(ctx);
    }

    std::any ParseTreeVisitor::visitConstdecl(TParser::ConstdeclContext *ctx) {
        std::cout << "In ParseTreeVisitor::" << __FUNCTION__;
        return visitChildren(ctx);
    }

    std::any ParseTreeVisitor::visitConstdef(TParser::ConstdefContext *ctx) {
        std::cout << "In ParseTreeVisitor::" << __FUNCTION__;
        return visitChildren(ctx);
    }

    std::any ParseTreeVisitor::visitConstexpr(TParser::ConstexprContext *ctx) {
        std::cout << "In ParseTreeVisitor::" << __FUNCTION__;
        return visitChildren(ctx);
    }

    std::any ParseTreeVisitor::visitConstinitval(TParser::ConstinitvalContext *ctx) {
        std::cout << "In ParseTreeVisitor::" << __FUNCTION__;
        return visitChildren(ctx);
    }

    std::any ParseTreeVisitor::visitDecl(TParser::DeclContext *ctx) {
        std::cout << "In ParseTreeVisitor::" << __FUNCTION__;
        return visitChildren(ctx);
    }

    std::any ParseTreeVisitor::visitExpr(TParser::ExprContext *ctx) {
        std::cout << "In ParseTreeVisitor::" << __FUNCTION__;
        return visitChildren(ctx);
    }

    std::any ParseTreeVisitor::visitFuncdef(TParser::FuncdefContext *ctx) {
        std::cout << "In ParseTreeVisitor::" << __FUNCTION__;
        return visitChildren(ctx);
    }

    std::any ParseTreeVisitor::visitFuncfparam(TParser::FuncfparamContext *ctx) {
        std::cout << "In ParseTreeVisitor::" << __FUNCTION__;
        return visitChildren(ctx);
    }

    std::any ParseTreeVisitor::visitFuncfparams(TParser::FuncfparamsContext *ctx) {
        std::cout << "In ParseTreeVisitor::" << __FUNCTION__;
        return visitChildren(ctx);
    }

    std::any ParseTreeVisitor::visitFuncrparams(TParser::FuncrparamsContext *ctx) {
        std::cout << "In ParseTreeVisitor::" << __FUNCTION__;
        return visitChildren(ctx);
    }

    std::any ParseTreeVisitor::visitFunctype(TParser::FunctypeContext *ctx) {
        std::cout << "In ParseTreeVisitor::" << __FUNCTION__;
        return visitChildren(ctx);
    }

    std::any ParseTreeVisitor::visitGlobalexpr(TParser::GlobalexprContext *ctx) {
        std::cout << "In ParseTreeVisitor::" << __FUNCTION__;
        return visitChildren(ctx);
    }

    std::any ParseTreeVisitor::visitInitval(TParser::InitvalContext *ctx) {
        std::cout << "In ParseTreeVisitor::" << __FUNCTION__;
        return visitChildren(ctx);
    }

    std::any ParseTreeVisitor::visitLval(TParser::LvalContext *ctx) {
        std::cout << "In ParseTreeVisitor::" << __FUNCTION__;
        return visitChildren(ctx);
    }

    std::any ParseTreeVisitor::visitProgram(TParser::ProgramContext *ctx) {
        std::cout << "In ParseTreeVisitor::" << __FUNCTION__;
        return visitChildren(ctx);
    }

    std::any ParseTreeVisitor::visitStmt(TParser::StmtContext *ctx) {
        std::cout << "In ParseTreeVisitor::" << __FUNCTION__;
        return visitChildren(ctx);
    }

    std::any ParseTreeVisitor::visitVardecl(TParser::VardeclContext *ctx) {
        std::cout << "In ParseTreeVisitor::" << __FUNCTION__;
        return visitChildren(ctx);
    }

    std::any ParseTreeVisitor::visitVardef(TParser::VardefContext *ctx) {
        std::cout << "In ParseTreeVisitor::" << __FUNCTION__;
        return visitChildren(ctx);
    }
}
