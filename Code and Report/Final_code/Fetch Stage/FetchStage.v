// Fetch Stage

// The fetch stage includes the instruction memory hardware unit.
// This unit reads 10 bytes from memory at a time, using the PC as the address of
// the first byte (byte 0).

// This byte is interpreted as the instruction byte and is split (by the module labeled “Split”) into two 4-bit quantities.
// The output of this module is two variables icode and ifun which are respectively the instruction and function codes.
// These variables equals either the values read from memory or, in the event that the instruction address is not valid (as indicated by the signal imem_error), 
// the values corresponding to a nop instruction. Based on the value of icode, we can compute three 1-bit signals

module FetchStage(input [7:0] ibyte, output [3:0] icode, output [3:0] ifun);
    assign icode = ibyte[7:4];
    assign ifun = ibyte[3:0];
endmodule

// instr_valid - Indicates if this byte correspond to a legal Y86-64 instruction. This signal is used to detect an illegal instruction.
// need_regids - Indicates if this instruction include a register specifier byte.
// need_valC - Indicates if this instruction include a constant word.
// Extract immediate word from 9 bytes of instruction
module align(ibytes, need_regids, rA, rB, valC);
    input need_regids;
    input [71:0] ibytes;
    output [ 3:0] rA;
    output [ 3:0] rB;
    output [63:0] valC;
    assign rA = ibytes[3:0];
    assign rB = ibytes[7:4];
    assign valC = need_regids ? ibytes[71:8] : ibytes[63:0];
endmodule

// PC incrementer depends on whether we have set bit in need_regids and need_valC so that we increment the value of PC by the appropriate value to fetch the next instruction
module PC_increment(pc, need_regids, need_valC, valP);
    input need_regids;
    input need_valC;
    input [63:0] pc 
    output [63:0] valP;
    assign valP = pc + 1 + 8*need_valC + need_regids;
endmodule