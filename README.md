# ALU Design and Verification

## Project Overview
This project implements a Verilog-based Arithmetic Logic Unit (ALU) and verifies its functionality using a self-checking testbench environment.  
The ALU performs basic arithmetic and logical operations and is verified using a modular testbench architecture.

---

## ALU Operations
The ALU supports the following operations:

- Addition (Unsigned)
- Subtraction (Unsigned)
- Addition with CIN
- Subtraction with CIN
- Increment Operand A
- Decrement Operand A
- Increment Operand B
- Decrement Operand B
- Comparison
- Increment both Operand A and Operand B, then multiply
- Shift left by 1 Operand A, then multiply
- Signed Addition with comparison of Operand A and Operand B
- Signed Subtraction with comparison of Operand A and Operand B
- Bitwise AND
- Bitwise OR
- Bitwise NAND
- Bitwise NOR
- Bitwise XOR
- Bitwise XNOR
- NOT of Operand A
- NOT of Operand B
- Shift right by 1 Operand A
- Shift left by 1 Operand A
- Shift right by 1 Operand B
- Shift left by 1 Operand B
- Rotate left Operand A by B
- Rotate right Operand A by B

---

## Timing Information
Most arithmetic and logical operations use **1 clock cycle latency**.  
Multiplication operations use **2-cycle processing latency** (total 3 clock cycles).

---

## Verification
The verification is done using a modular testbench consisting of:

- **Driver**: Generates and sends stimulus to the DUT  
- **Scoreboard**: Compares expected and actual outputs  
- **Top Testbench**: Connects all components and DUT  

---

## Tools Used
- Vivado  
- Questa SIM  
