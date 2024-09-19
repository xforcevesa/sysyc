#include "visitor.h"

namespace SysycFrontend {
    std::any ParseTreeVisitor::visitChildren(antlr4::tree::ParseTree *node)
    {
        // std::cout << node->toString();
        for (const auto item: node->children) {
            std::cout << " : " << item->toString();
        }
        std::cout << std::endl;
        return TParserBaseVisitor::visitChildren(node);
    }
}
