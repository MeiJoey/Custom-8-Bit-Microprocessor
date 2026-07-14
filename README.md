# 8-Bit Memoryless Microprocessor with Instruction Decoder and ALU

A single-cycle, memoryless 8-bit microprocessor implemented in Verilog HDL and deployed onto a Xilinx Basys 3 FPGA. This architecture features a custom 4-bit opcode instruction set capable of executing 16 arithmetic, logical, and register-transfer operations.

## System Architecture
* **Instruction Decoder:** A $4\times16$ decoder that translates 4-bit opcodes into one-hot control signals.
* **Registers:** Three synchronous 8-bit registers (RegA, RegB, RegC) for operand storage and computation results.
* **ALU:** Executes 16 unique operations including addition (with `Cout`), subtraction, logical shifts (`LSL`/`LSR`), increments, decrements, and bitwise logic (`AND`/`OR`).
* **Hardware I/O:** Features a 10ms hardware debounce module for single-cycle execution via pushbuttons, physical slide-switch data entry, and multiplexed 7-segment display tracking.

## Technical Specifications & Features
* **Language:** Verilog HDL
* **Toolchain:** Xilinx Vivado 
* **Target Hardware:** Basys 3 FPGA (Artix-7)

## Verification & Simulation
Functional verification was performed using behavioral Verilog testbenches to validate the complete instruction set execution flow. 
* *Simulation Tip:* To expedite testbench behavioral verification, the physical 10ms debounce logic counter was bypassed to allow fluid continuous-enable execution tracking via the Vivado Tcl Console.

## How to Run
1. Clone this repository.
2. Open Xilinx Vivado and create a new project targeting the **Basys 3 board**.
3. Import all files from the `src/` and `sim/` directories.
4. Import the `constraints/basys3_constraints.xdc` file.
5. Run Behavioral Simulation to view waveforms, or Run Synthesis & Implementation to generate the bitstream and program the physical FPGA hardware.
