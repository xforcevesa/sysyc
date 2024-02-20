#pragma once

#include <iostream>
#include <fstream>
#include "antlr4-runtime.h"
#include "TLexer.h"
#include "TParser.h"

class compiler final {
public:
    compiler(int, char**);
    [[nodiscard]] int exec() const;
private:
    static std::string getFileContent(char*);
    std::string src;
};
