# minimum required CMAKE version
CMAKE_MINIMUM_REQUIRED(VERSION 3.7 FATAL_ERROR)

project(sysyc)

# For good experience in CLion
include_directories(build/antlr4cpp_generated_src/TLexer)
include_directories(build/antlr4cpp_generated_src/TParser)
include_directories(build/antlr4_runtime/src/antlr4_runtime/runtime/Cpp/runtime/src)

add_compile_options(-std=c++17 -O3 -march=native)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

# compiler must be 17
set(CMAKE_CXX_STANDARD 17)

# required if linking to static library
add_definitions(-DANTLR4CPP_STATIC)

# using /MD flag for antlr4_runtime (for Visual C++ compilers only)
set(ANTLR4_WITH_STATIC_CRT OFF)

# Specify the version of the antlr4 library needed for this project.
# By default the latest version of antlr4 will be used.  You can specify a
# specific, stable version by setting a repository tag value or a link
# to a zip file containing the libary source.
# set(ANTLR4_TAG 4.13.1)
# set(ANTLR4_ZIP_REPOSITORY https://github.com/antlr/antlr4/archive/refs/tags/4.13.1.zip)

# add external build for antlrcpp
include(ExternalAntlr4Cpp)
# add antrl4cpp artifacts to project environment
include_directories(${ANTLR4_INCLUDE_DIRS})

# set variable pointing to the antlr tool that supports C++
# this is not required if the jar file can be found under PATH environment
set(ANTLR_EXECUTABLE ${CMAKE_CURRENT_SOURCE_DIR}/antlr-4.13.1-complete.jar)
# add macros to generate ANTLR Cpp code from grammar
find_package(ANTLR REQUIRED)

# Call macro to add lexer and grammar to your build dependencies.
antlr_target(SampleGrammarLexer TLexer.g4 LEXER
        PACKAGE SysycFrontend)
antlr_target(SampleGrammarParser TParser.g4 PARSER LISTENER VISITOR
        PACKAGE SysycFrontend
        DEPENDS_ANTLR SampleGrammarLexer
        COMPILE_FLAGS -lib ${ANTLR_SampleGrammarLexer_OUTPUT_DIR})


# include generated files in project environment
include_directories(${ANTLR_SampleGrammarLexer_OUTPUT_DIR})
include_directories(${ANTLR_SampleGrammarParser_OUTPUT_DIR})
include_directories(${ANTLR_SampleGrammarVisitor_OUTPUT_DIR})

# add generated grammar to demo binary target
add_executable(sysyc main.cpp
        ${ANTLR_SampleGrammarLexer_CXX_OUTPUTS}
        ${ANTLR_SampleGrammarParser_CXX_OUTPUTS}
        ${ANTLR_SampleGrammarVisitor_CXX_OUTPUTS}
        src/compiler.cpp
        src/compiler.h
        src/visitor.cpp
        src/visitor.h
        src/error.cpp
        src/error.h)

target_link_libraries(sysyc antlr4_static)
