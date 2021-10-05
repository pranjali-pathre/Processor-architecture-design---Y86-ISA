// `include "ClockedRegER.v"
// 0- ADD, 1- SUB, 2- AND, 3- exclusive-or
module alu(input [63:0] aluA, input [63:0] aluB, input [3:0] alufun, output [63:0] valE, output [2:0] new_cc);
    assign valE = alufun == 4'h0 ? aluB + aluA : alufun == 4'h1 ? aluB - aluA : alufun == 4'h2 ? aluB & aluA : alufun == 4'h3 ? aluB^aluA : alufun;
    // new_cc[2] corresponds to zero flag new_cc[1] corresponds to ;
    assign new_cc[2] = (valE == 0);
    assign new_cc[1] = valE[63];
    assign new_cc[0] = alufun == 4'h0 ? (aluA[63] == aluB[63]) & (aluA[63] != valE[63]) : alufun == 4'h1 ? (~alu[63] == aluB[63] & (aluB[63] != valE[63])): 0;
endmodule

module cc(output [2:0] cc, input [2:0] new_cc, input set_cc, input reset, input clock);
    pipelinedreg3 c(cc, new_cc, ~set_cc, 3'b100, clock);
endmodule

// // Clocked register with enable signal and synchronous reset
// // Default width is 3, but can be changed
// module clcreg3( output [2:0] out, input [2:0] in, input enable, input reset, input [2:0] value, input clock);
//     reg [2:0] out;
//     always
//     // Flush the required value in the out reg depending on the reset and enable on every positive edge of clock.
//         @(posedge clock)
//         begin
//         // Reset if the reselt value is 1 i.e., out=value else if enable is 1 in=out
//         if (reset)
//             out <= value;
//         else if (enable)
//             out <= in;
//         end
// endmodule

module cond(input [3:0] ifun, input [2:0] cc, output Cnd);
    wire zf = cc[2];
    wire sf = cc[1];
    wire of = cc[0];
    assign Cnd = (ifun == 4'h0) | (ifun ==  4'h1 & ((sf^of)|zf)) | (ifun == 4'h2 & (sf^of)) | (ifun == 4'h3 & zf) | (ifun == 4'h4 & ~zf) | (ifun == 4'h5 & (~sf^of)) | (ifun == 4'h6 & (~sf^of)&~zf);
endmodule