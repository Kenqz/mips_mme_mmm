# Assembly Programs: `mmm.asm` and `mme.asm`

## Table of Contents
- [Introduction](#introduction)
- [File Descriptions](#file-descriptions)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgements](#acknowledgements)

## Introduction
This repository contains two assembly language programs: `mmm.asm` and `mme.asm`. These programs are written in x86 assembly language and are designed to perform specific tasks. 

- `mmm.asm`: Performs matrix multiplication.
- `mme.asm`: Performs matrix element-wise multiplication.

## File Descriptions

### `mmm.asm`
This file contains the assembly code for performing matrix multiplication. It multiplies two matrices and stores the result in a third matrix.

### `mme.asm`
This file contains the assembly code for performing element-wise multiplication of two matrices. Each element in the resulting matrix is the product of the corresponding elements in the input matrices.

## Prerequisites
To assemble and run these programs, you need:
- An x86 assembler (e.g., NASM)
- An x86 emulator or environment to run the assembled code (e.g., DOSBox, QEMU)
- A linker (if needed)

## Installation
1. Clone this repository to your local machine:
    ```sh
    git clone https://github.com/yourusername/assembly-matrix-operations.git
    cd assembly-matrix-operations
    ```

2. Ensure you have NASM installed. If not, install it using:
    ```sh
    # For Debian-based systems
    sudo apt-get install nasm
    
    # For MacOS using Homebrew
    brew install nasm
 
3. Install QTspim   

## Usage
### Assembling the Programs
To assemble the `mmm.asm` file, use the following command:
```sh
nasm -f elf64 mmm.asm -o mmm.o