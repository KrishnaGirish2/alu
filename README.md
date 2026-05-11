# ALU Design and Verification

## Project Overview:
This project implements a Verilog-based Arithmetic Logic Unit (ALU) and verifies its functionality using a self-checking testbench environment.
The ALU performs basic arithmetic and logical operations and is verified using a modular testbench architecture.
---
## ALU Operations:
The ALU supports the following operations:
-Addition (Unsigned) 
-Subtraction (Unsigned)
-Addition with CIN
-Subtraction with CIN
-Increment Operand A
-Decrement Operand A
-Increment Operand B
-Decrement Operand B
-Comparison
-Increment both Operand A and Operand B and then multiply
-Shift left by 1 Operand A and then multiply
-Signed Addition with comparison of Operand A and Operand B (Signed)
-Signed Subtraction with comparison of Operand A and Operand B (Signed)
-Bitwise AND
-Bitwise OR
-Bitwise NAND
-Bitwise NOR
-Bitwise XOR
-Bitwise XNOR
-NOT of Operand A
-NOT of Operand B
-Shift right 1 Operand A
-Shift left  1 Operand A
-Shift right 1 Operand B
-Shift left 1 Operand B
-Rotate left Operand A by B
-Rotate right Operand A by B
---

Most of the arithmetic and logical operations uses 1 clock cycle delay and multiplication operation use 2 cycle processing latency( 3 clock cycle total timing)
---
## Verification:
The verification is done using a modular testbench consisting of:

- **Driver**: Generates and sends stimulus to the DUT
- **Scoreboard**: Compares expected and actual outputs
- **Top Testbench**: Connects all components and DUT
---

## Tools Used:
-Vivado
-Questa SIM
---
  
