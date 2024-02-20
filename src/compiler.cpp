#include "compiler.h"
#include "error.h"
#include "visitor.h"

compiler::compiler(const int argc, char** argv) {
    std::cout << "sysyc version 0.1 by nomodeset" << std::endl;

    if (argc < 2) {
        fprintf(stderr, "Usage: %s [source]\nFor "
                        "example: %s ../example/case1.c\n", argv[0], argv[0]);
        exit(-1);
    }

    this->src = getFileContent(argv[1]);
}

std::string compiler::getFileContent(char* name) {
    std::ifstream file(name);
    if (!file.good()) {
        fprintf(stderr, "File %s not found", name);
        exit(-1);
    }
    auto ret = std::string(std::istreambuf_iterator<char>(file), std::istreambuf_iterator<char>());
    // std::cout << ret << std::endl;
    file.close();
    return ret;
}

int compiler::exec() const {
    // Initialize input stream
    antlr4::ANTLRInputStream input(this->src);

    // Initialize lexer
    const auto lexer = new SysycFrontend::TLexer(&input);

    // Set lexer listener to customize lexer errors
    const auto lexer_error_listener = new SysycFrontend::SimpleListener();
    lexer->removeErrorListeners();
    lexer->addErrorListener(lexer_error_listener);

    // Setup and generate tokens
    const auto token_stream = new antlr4::CommonTokenStream(lexer);
    token_stream->fill();

    // Traverse and print tokens
    for (const auto token : token_stream->getTokens()) {
        std::cout << token->toString() << std::endl;
    }

    // Initialize parser and set error listener
    const auto parser = new SysycFrontend::TParser(token_stream);
    const auto parser_error_listener = new SysycFrontend::SimpleListener();
    parser->removeErrorListeners();
    parser->addErrorListener(parser_error_listener);

    // Parse tokens upon "program" rules defined in TParser.g4
    const auto tree = parser->program();

    // Print parse tree in the shape of S-expression
    std::cout << tree->toStringTree(parser) << std::endl;

    // Initialize visitor to traverse the parse tree and generate IR
    const auto visitor = new SysycFrontend::ParseTreeVisitor();
    visitor->visit(tree);

    // Release created objects
    delete lexer;
    delete parser;
    delete visitor;
    delete lexer_error_listener;
    delete parser_error_listener;

    return 0;
}
