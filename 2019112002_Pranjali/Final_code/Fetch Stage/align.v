// instr_valid - Indicates if this byte correspond to a legal Y86-64 instruction. This signal is used to detect an illegal instruction.
// need_regids - Indicates if this instruction include a register specifier byte.
// need_valC - Indicates if this instruction include a constant word.
// Extract immediate word from 9 bytes of instruction
module align(input [71:0] ibytes, input need_regids, output [ 3:0]  rA, output [ 3:0]  rB, output [63:0] valC);
    assign rA = ibytes[71:68];
    assign rB = ibytes[67:64];
    assign valC = need_regids ? ibytes[63:0] : ibytes[71:8];
endmodule