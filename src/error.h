#pragma once

#include "antlr4-runtime.h"

namespace SysycFrontend {

    class SimpleListener final: public antlr4::BaseErrorListener{
    public:
        void syntaxError(antlr4::Recognizer *, antlr4::Token *, size_t, size_t, const std::string &, std::exception_ptr) override;
    };

} // SysycFrontend

