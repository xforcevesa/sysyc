# sysyc

## Synopsis

- An implementation of SysY2022 compiler based on RISC-V ISA.

- Using ```antlr4``` to build up lexer and parser.

## How to Run

- Build it using the following commands.

```bash
mkdir build
cd build/
cmake ..
make -j$(nproc)
```

- During the building time, it will perform a ```git pull``` from the GitHub repository of antlr4. Please confirm you have a good network environment.

- Then you'll see the target executable file is in the ```build``` directory.

## Recommended IDE Configuration

### Visual Studio Code

1. Install plugin ```CMake Tools```.
2. Build it once in the terminal in the ```build``` directory in the project workspace.
3. Add the following directories to the include path.
```
build/antlr4cpp_generated_src/TLexer
build/antlr4cpp_generated_src/TParser
build/antlr4_runtime/src/antlr4_runtime/runtime/Cpp/runtime/src
```
4. After the above steps, your CLion is enable to recognize the header files. Feel free to develop upon the code!

### CLion

1. Setup project from ```CMakeLists.txt``` file in the project root directory.
2. In CMake Configuration, set build directory to ```build```, and environment variables such as ```http_proxy```.
3. Click the run button to start building. 
4. After the above steps, your CLion is enable to recognize the header files. Feel free to develop upon the code! 


