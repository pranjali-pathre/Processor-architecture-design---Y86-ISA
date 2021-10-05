// The fetch stage includes the instruction memory hardware unit.
// This unit reads 10 bytes from memory at a time, using the PC as the address of
// the first byte (byte 0).

// This byte is interpreted as the instruction byte and is split (by the module labeled “Split”) into two 4-bit quantities.
// The output of this module is two variables icode and ifun which are respectively the instruction and function codes.
// These variables equals either the values read from memory or, in the event that the instruction address is not valid (as indicated by the signal imem_error), 
// the values corresponding to a nop instruction. Based on the value of icode, we can compute three 1-bit signals

module split(input [7:0] ibyte, output [3:0] icode, output [3:0] ifun);
    assign icode = ibyte[7:4];
    assign ifun = ibyte[3:0];
endmodule