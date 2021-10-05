// The following are declarations of the internal signals of the fetch stage. They are all of type wire, meaning
// that they are simply connectors from one logic block to another.
wire    [63:0] f_predPC, F_predPC, f_pc;
wire    f_ok;
wire    imem_error;
wire    [ 2:0] f_stat;
wire    [79:0] f_instr;
wire    [ 3:0] imem_icode;
wire    [ 3:0] imem_ifun;
wire    [ 3:0] f_icode;
wire    [ 3:0] f_ifun;
wire    [ 3:0] f_rA;
wire    [ 3:0] f_rB;
wire    [63:0] f_valC;
wire    [63:0] f_valP;
wire    need_regids;
wire    need_valC;
wire    instr_valid;
wire    F_stall, F_bubble;

// The following signals must be included to allow pipeline registers F and D to be reset when either the
// processor is in RESET mode or the bubble signal is set for the pipeline register.

wire resetting = (mode == RESET_MODE);
wire F_reset = F_bubble | resetting;
wire D_reset = D_bubble | resetting;

// The different elements of pipeline registers F and D are generated as instantiations of the preg register
// module. Observe how these are instantiated with different widths, according to the number of bits in each
// element:

// All pipeline registers are implemented with module
preg(out, in, stall, bubble, bubbleval, clock)
// F Register
preg #(64) F_predPC_reg(F_predPC, f_predPC, F_stall, F_reset, 64’b0, clock);
// D Register
preg #(3) D_stat_reg(D_stat, f_stat, D_stall, D_reset, SBUB, clock);
preg #(64) D_pc_reg(D_pc, f_pc, D_stall, D_reset, 64’b0, clock);
preg #(4) D_icode_reg(D_icode, f_icode, D_stall, D_reset, INOP, clock);
preg #(4) D_ifun_reg(D_ifun, f_ifun, D_stall, D_reset, FNONE, clock);
preg #(4) D_rA_reg(D_rA, f_rA, D_stall, D_reset, RNONE, clock);
preg #(4) D_rB_reg(D_rB, f_rB, D_stall, D_reset, RNONE, clock);
preg #(64) D_valC_reg(D_valC, f_valC, D_stall, D_reset, 64’b0, clock);
preg #(64) D_valP_reg(D_valP, f_valP, D_stall, D_reset, 64’b0, clock);

assign f_pc = (((M_icode == IJXX) & ~M_Cnd) ? M_valA : (W_icode == IRET) ? W_valM :F_predPC);
assign f_icode = (imem_error ? INOP : imem_icode);
assign f_ifun = (imem_error ? FNONE : imem_ifun);
assign instr_valid = (f_icode == INOP | f_icode == IHALT | f_icode == IRRMOVQ | f_icode == IIRMOVQ | f_icode == IRMMOVQ | f_icode == IMRMOVQ | f_icode == IOPQ | f_icode == IJXX | f_icode == ICALL | f_icode == IRET | f_icode == IPUSHQ | f_icode == IPOPQ);
assign f_stat =(imem_error ? SADR :  ̃instr_valid ? SINS : (f_icode == IHALT) ? SHLT :SAOK);
assign need_regids = (f_icode == IRRMOVQ | f_icode == IOPQ | f_icode == IPUSHQ | f_icode == IPOPQ | f_icode == IIRMOVQ | f_icode == IRMMOVQ | f_icode == IMRMOVQ);
assign need_valC = (f_icode == IIRMOVQ | f_icode == IRMMOVQ | f_icode == IMRMOVQ | f_icode == IJXX | f_icode == ICALL);
assign f_predPC = ((f_icode == IJXX | f_icode == ICALL) ? f_valC : f_valP);

// Finally, we must instantiate the different modules implementing the hardware units we examined earlier:
split split(f_instr[7:0], imem_icode, imem_ifun);
align align(f_instr[79:8], need_regids, f_rA, f_rB, f_valC);
pc_increment pci(f_pc, need_regids, need_valC, f_valP);

// Clocked register with enable signal and synchronous reset
// Default width is 8, but can be overriden
module cenrreg(out, in, enable, reset, resetval, clock);
    parameter width = 8;
    output [width-1:0] out;
    reg [width-1:0] out;
    input [width-1:0] in;
    input enable;
    input reset;
    input [width-1:0] resetval;
    input sclock;
    always
        @(posedge clock)
        begin
            if (reset)
                out <= resetval;
            else if (enable)
                out <= in;
        end
endmodule

// Pipeline register. Uses reset signal to inject bubble
// When bubbling, must specify value that will be loaded
module preg(out, in, stall, bubble, bubbleval, clock);
    parameter width = 8;
    output [width-1:0] out;
    input [width-1:0] in;
    input stall, bubble;
    input [width-1:0] bubbleval;
    input clock;
    cenrreg #(width) r(out, in, ~stall, bubble, bubbleval, clock);
endmodule