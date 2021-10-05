// PC incrementer depends on whether we have set bit in need_regids and need_valC so that we increment the value of PC by the appropriate value to fetch the next instruction
module PC_increment(input [63:0] pc, input  need_regids, input need_valC,output [63:0] valP);
    assign valP = pc + 1 + 8*need_valC + need_regids;
endmodule