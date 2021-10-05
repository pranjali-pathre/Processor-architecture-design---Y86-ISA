# Final-assignment
## OVERVIEW

Developed a processor architecture design based on the Y86 ISA using Verilog. The design is thoroughly tested to satisfy all the specification requirements using simulations. It includes
* A report describing the design details of the various stages of the processor architecture, the supported features
(including simulation snapshots of the features supported) and the challenges encountered.
* Verilog code for processor design and testbench


## INSTRUCTIONS TO RUN THE CODE FILE
1. Download the codes.
2. Run in terminal: iverilog -o processor_test processor_test.v processor.v
3. ./a.out
4. gtkwave processor_test.vcd
5. For changing the instruction set change the file instr.mem to the required file.
6. Individual testbenches have also been provided for checking the functionality for different
modules.

## SPECIFICATIONS
ALU is built with the following functionality:
* ADD - 64bits
* SUB - 64bits
* AND - 64bits
* XOR - 64bits

Input and output of all the blocks is in signed 2’s complement.
