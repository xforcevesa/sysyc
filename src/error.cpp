#include "error.h"

namespace SysycFrontend {
    void SimpleListener::syntaxError(antlr4::Recognizer *recognizer, antlr4::Token *offendingSymbol, size_t line, size_t charPositionInLine, const std::string &msg, std::exception_ptr e) {
        std::cerr << "Error at line " << line << ":" << charPositionInLine << " - " << msg << std::endl;
        exit(1);
    }
}
