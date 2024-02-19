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

## Notice

- If you'd like to participate in the maintenance of this project, please remove the build directory and then push it to your upstream.


