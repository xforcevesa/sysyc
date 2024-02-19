/* Copyright (c) 2012-2017 The ANTLR Project. All rights reserved.
 * Use of this file is governed by the BSD 3-clause license that
 * can be found in the LICENSE.txt file in the project root.
 */

//
//  main.cpp
//  antlr4-cpp-demo
//
//  Created by Mike Lischke on 13.03.16.
//

#include <iostream>

#include "antlr4-runtime.h"
#include "TLexer.h"
#include "TParser.h"

using namespace antlrcpptest;
using namespace antlr4;

int main(int argc, const char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s [source]\nFor example: %s ../example/case1.c\n", argv[0], argv[0]);
        exit(-1);
    }
    std::ifstream file(argv[1]);
    ANTLRInputStream input(file);
    TLexer lexer(&input);
    CommonTokenStream tokens(&lexer);

    tokens.fill();
    for (auto token : tokens.getTokens()) {
        std::cout << token->toString() << std::endl;
    }

    TParser parser(&tokens);
    tree::ParseTree* tree = parser.program();

    std::cout << tree->toStringTree(&parser) << std::endl << std::endl;

    return 0;
}