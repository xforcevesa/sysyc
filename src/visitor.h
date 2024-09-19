#pragma once

#include "TParserBaseVisitor.h"

#define DEBUG

using SysycFrontend::TParser;

namespace SysycFrontend {
    class ParseTreeVisitor final : public TParserBaseVisitor
    {
        std::any visitChildren(antlr4::tree::ParseTree *node) override;
    };
}
