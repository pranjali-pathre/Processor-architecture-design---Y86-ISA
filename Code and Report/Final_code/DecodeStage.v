// `include "ClockedRegER.v"
// Decode stage
// The instruction fields are decoded to generate register identifiers for four addresses (two read and two write) used by
// the register file. The values read from the register file become the signals valA and valB.
// The two write-back values valE and valM serve as the data for the writes.
 module regfile( input [ 3:0] dstE, input [63:0] valE, input [ 3:0] dstM, input [63:0] valM, input [ 3:0] srcA, output [63:0] valA,input [ 3:0] srcB, output [63:0] valB, input reset, input clock, output [63:0] rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi, r8, r9, r10, r11, r12, r13, r14);
     // We need to update the value in the registers contained in the register file in each cycle and update them with the required value which will be used in the next cycle.
     // output [63:0] rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi, r8, r9, r10, r11, r12, r13, r14;
     // Input data for each register
     wire [63:0] data_rax, data_rcx, data_rdx, data_rbx, data_rsp, data_rbp, data_rsi, data_rdi, data_r8, data_r9, data_r10, data_r11, data_r12, data_r13, data_r14;
     // Input write controls for each register
     wire wire_rax, wire_rcx, wire_rdx, wire_rbx, wire_rsp, wire_rbp, wire_rsi, wire_rdi, wire_r8, wire_r9, wire_r10, wire_r11, wire_r12, wire_r13, wire_r14;
     parameter RRAX = 4'h0;
     parameter RRCX = 4'h1;
     parameter RRDX = 4'h2;
     parameter RRBX = 4'h3;
     parameter RRSP = 4'h4;
     parameter RRBP = 4'h5;
     parameter RRSI = 4'h6;
     parameter RRDI = 4'h7;
     parameter R8 = 4'h8;
     parameter R9 = 4'h9;
     parameter R10 = 4'ha;
     parameter R11 = 4'hb;
     parameter R12 = 4'hc;
     parameter R13 = 4'hd;
     parameter R14 = 4'he;
     parameter RRNONE = 4'hf;
     // AT the beginning of thr cycle we update the necessary values in the registers on the positive edge of the clock 
     // Implement with clocked registers
     reg temp = 1'b0;
     clcreg64 reg_rax(rax, data_rax, wire_rax, temp, 64'b0, clock);
     clcreg64 reg_rcx(rcx, data_rcx, wire_rcx, temp, 64'b0, clock);
     clcreg64 reg_rdx(rdx, data_rdx, wire_rdx, temp, 64'b0, clock);
     clcreg64 reg_rbx(rbx, data_rbx, wire_rbx, temp, 64'b0, clock);
     clcreg64 reg_rsp(rsp, data_rsp, wire_rsp, temp, 64'b0, clock);
     clcreg64 reg_rbp(rbp, data_rbp, wire_rbp, temp, 64'b0, clock);
     clcreg64 reg_rsi(rsi, data_rsi, wire_rsi, temp, 64'b0, clock);
     clcreg64 reg_rdi(rdi, data_rdi, wire_rdi, temp, 64'b0, clock);
     clcreg64 reg_r8( r8,  data_r8,  wire_r8,  temp, 64'b0, clock);
     clcreg64 reg_r9( r9,  data_r9,  wire_r9,  temp, 64'b0, clock);
     clcreg64 reg_r10(r10, data_r10, wire_r10, temp, 64'b0, clock);
     clcreg64 reg_r11(r11, data_r11, wire_r11, temp, 64'b0, clock);
     clcreg64 reg_r12(r12, data_r12, wire_r12, temp, 64'b0, clock);
     clcreg64 reg_r13(r13, data_r13, wire_r13, temp, 64'b0, clock);
     clcreg64 reg_r14(r14, data_r14, wire_r14, temp, 64'b0, clock);
 // //  Output the value of valA for the necessary register. 
 // //  valA value is outputted on the basis of whether the value in srcA matches with which register number.
 //     assign valA = srcA == 4’h0 ? rax : srcA == 4’h1 ? rcx : srcA == 4’h2 ? rdx : srcA == 4’h3 ? rbx : srcA == 4’h4 ? rsp : srcA == 4’h5 ? rbp : srcA == 4’h6 ? rsi : srcA == 4’h7 ? rdi : srcA == 4’h8 ? r8 : srcA == 4’h9 ? r9 : srcA == 4’ha ? r10 : srcA == 4’hb ? r11 : srcA == 4’hc ? r12 : srcA == 4’hd ? r13 : srcA == 4’he ? r14 : 0;
 // //  Output the value of valB for the necessary register. 
 // //  valB value is outputted on the basis of whether the value in srcB matches with which register number.
 //     assign valB = srcB == 4’h0 ? rax : srcB == 4’h1 ? rcx : srcB == 4’h2 ? rdx : srcB == 4’h3 ? rbx : srcB == 4’h4 ? rsp : srcB == 4’h5 ? rbp : srcB == 4’h6 ? rsi : srcB == 4’h7 ? rdi : srcB == 4’h8 ? r8 : srcB == 4’h9 ? r9 : srcB == 4’ha ? r10 : srcB == 4’hb ? r11 : srcB == 4’hc ? r12 : srcB == 4’hd ? r13 : srcB == 4’he ? r14 : 0
 // //  Next we update the data wire corresponding to each register based on whether the value in valM matches whichever register number.
 //     assign data_rax = dstM == 4’h0 ? valM : valE;
 //     assign data_rcx = dstM == 4’h1 ? valM : valE;
 //     assign data_rdx = dstM == 4’h2 ? valM : valE;
 //     assign data_rbx = dstM == 4’h3 ? valM : valE;
 //     assign data_rsp = dstM == 4’h4 ? valM : valE;
 //     assign data_rbp = dstM == 4’h5 ? valM : valE;
 //     assign data_rsi = dstM == 4’h6 ? valM : valE;
 //     assign data_rdi = dstM == 4’h7 ? valM : valE;
 //     assign data_r8 =  dstM == 4’h8 ? valM : valE; 
 //     assign data_r9 =  dstM == 4’h9 ? valM : valE; 
 //     assign data_r10 = dstM == 4’ha ? valM : valE;
 //     assign data_r11 = dstM == 4’hb ? valM : valE;
 //     assign data_r12 = dstM == 4’hc ? valM : valE;
 //     assign data_r13 = dstM == 4’hd ? valM : valE;
 //     assign data_r14 = dstM == 4’he ? valM : valE;  
 // //  Next we update the data every register wire corresponding to each register based on whether the value in valE matches whichever register number.
 //     assign wire_rax = dstM == 4’h0 | dstE == 4’h0 
 //     assign wire_rcx = dstM == 4’h1 | dstE == 4’h1 
 //     assign wire_rdx = dstM == 4’h2 | dstE == 4’h2 
 //     assign wire_rbx = dstM == 4’h3 | dstE == 4’h3 
 //     assign wire_rsp = dstM == 4’h4 | dstE == 4’h4 
 //     assign wire_rbp = dstM == 4’h5 | dstE == 4’h5 
 //     assign wire_rsi = dstM == 4’h6 | dstE == 4’h6 
 //     assign wire_rdi = dstM == 4’h7 | dstE == 4’h7 
 //     assign wire_r8 = dstM ==  4’h8 | dstE == 4’h8
 //     assign wire_r9 = dstM ==  4’h9 | dstE == 4’h9
 //     assign wire_r10 = dstM == 4’ha | dstE == 4’ha 
 //     assign wire_r11 = dstM == 4’hb | dstE == 4’hb 
 //     assign wire_r12 = dstM == 4’hc | dstE == 4’hc 
 //     assign wire_r13 = dstM == 4’hd | dstE == 4’hd 
 //     assign wire_r14 = dstM == 4’he | dstE == 4’he  
 assign valA =
  srcA == RRAX ? rax :
  srcA == RRCX ? rcx :
  srcA == RRDX ? rdx :
  srcA == RRBX ? rbx :
  srcA == RRSP ? rsp :
  srcA == RRBP ? rbp :
  srcA == RRSI ? rsi :
  srcA == RRDI ? rdi :
  srcA == R8 ? r8 :
  srcA == R9 ? r9 :
  srcA == R10 ? r10 :
  srcA == R11 ? r11 :
  srcA == R12 ? r12 :
  srcA == R13 ? r13 :
  srcA == R14 ? r14 :
  0;
  assign valB =
  srcB == RRAX ? rax :
  srcB == RRCX ? rcx :
  srcB == RRDX ? rdx :
  srcB == RRBX ? rbx :
  srcB == RRSP ? rsp :
  srcB == RRBP ? rbp :
  srcB == RRSI ? rsi :
  srcB == RRDI ? rdi :
  srcB == R8 ? r8 :
  srcB == R9 ? r9 :
  srcB == R10 ? r10 :
  srcB == R11 ? r11 :
  srcB == R12 ? r12 :
  srcB == R13 ? r13 :
  srcB == R14 ? r14 :
  0;
  assign data_rax = dstM == RRAX ? valM : valE;
  assign data_rcx = dstM == RRCX ? valM : valE;
  assign data_rdx = dstM == RRDX ? valM : valE;
  assign data_rbx = dstM == RRBX ? valM : valE;
  assign data_rsp = dstM == RRSP ? valM : valE;
  assign data_rbp = dstM == RRBP ? valM : valE;
  assign data_rsi = dstM == RRSI ? valM : valE;
  assign data_rdi = dstM == RRDI ? valM : valE;
  assign data_r8 = dstM == R8 ? valM : valE;
  assign data_r9 = dstM == R9 ? valM : valE;
  assign data_r10 = dstM == R10 ? valM : valE;
  assign data_r11 = dstM == R11 ? valM : valE;
  assign data_r12 = dstM == R12 ? valM : valE;
  assign data_r13 = dstM == R13 ? valM : valE;
  assign data_r14 = dstM == R14 ? valM : valE;

  assign wire_rax = dstM == RRAX | dstE == RRAX;
  assign wire_rcx = dstM == RRCX | dstE == RRCX;
  assign wire_rdx = dstM == RRDX | dstE == RRDX;
  assign wire_rbx = dstM == RRBX | dstE == RRBX;
  assign wire_rsp = dstM == RRSP | dstE == RRSP;
  assign wire_rbp = dstM == RRBP | dstE == RRBP;
  assign wire_rsi = dstM == RRSI | dstE == RRSI;
  assign wire_rdi = dstM == RRDI | dstE == RRDI;
  assign wire_r8 = dstM == R8 | dstE == R8;
  assign wire_r9 = dstM == R9 | dstE == R9;
  assign wire_r10 = dstM == R10 | dstE == R10;
  assign wire_r11 = dstM == R11 | dstE == R11;
  assign wire_r12 = dstM == R12 | dstE == R12;
  assign wire_r13 = dstM == R13 | dstE == R13;
  assign wire_r14 = dstM == R14 | dstE == R14;
 endmodule

// // Clocked register with enable signal and synchronous reset
//  // Default width is 8, but can be overriden
//  module cenrreg(out, in, enable, reset, resetval, clock);
//  parameter width = 8;
//  output [width-1:0] out;
//  reg [width-1:0] out;
//  input [width-1:0] in;
//  input enable;
//  input reset;
//  input [width-1:0] resetval;
//  input clock;

//  always @(posedge clock) begin
//     if (reset)
//         out <= resetval;
//     else if (enable)
//         out <= in;
//     end
//  endmodule

//  // Pipeline register. Uses reset signal to inject bubble
//  // When bubbling, must specify value that will be loaded
//  module preg(out, in, stall, bubble, bubbleval, clock);

//  parameter width = 8;
//  output [width-1:0] out;
//  input [width-1:0] in;
//  input stall, bubble;
//  input [width-1:0] bubbleval;
//  input clock;

//  cenrreg #(width) r(out, in, ~stall, bubble, bubbleval, clock);
//  endmodule


//  // Register file
//  module regfile(dstE, valE, dstM, valM, srcA, valA, srcB, valB, reset, clock,
//  rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi,
//  r8, r9, r10, r11, r12, r13, r14);
//  input [ 3:0] dstE;
//  input [63:0] valE;
//  input [ 3:0] dstM;
//  input [63:0] valM;
//  input [ 3:0] srcA;
//  output [63:0] valA;
//  input [ 3:0] srcB;
//  output [63:0] valB;
//  input reset; // Set registers to 0
//  input clock;
//  // Make individual registers visible for debugging
//  output [63:0] rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi,
//  r8, r9, r10, r11, r12, r13, r14;

//  // Define names for registers used in HCL code

// parameter RRAX = 4'h0;
// parameter RRCX = 4'h1;
// parameter RRDX = 4'h2;
// parameter RRBX = 4'h3;
// parameter RRSP = 4'h4;
// parameter RRBP = 4'h5;
// parameter RRSI = 4'h6;
// parameter RRDI = 4'h7;
// parameter R8 = 4'h8;
// parameter R9 = 4'h9;
// parameter R10 = 4'ha;
// parameter R11 = 4'hb;
// parameter R12 = 4'hc;
// parameter R13 = 4'hd;
// parameter R14 = 4'he;
// parameter RRNONE = 4'hf;

//  // Input data for each register
//  wire [63:0] rax_dat, rcx_dat, rdx_dat, rbx_dat,
//  rsp_dat, rbp_dat, rsi_dat, rdi_dat,
//  r8_dat, r9_dat, r10_dat, r11_dat,

//  r12_dat, r13_dat, r14_dat;

//  // Input write controls for each register
//  wire rax_wrt, rcx_wrt, rdx_wrt, rbx_wrt,
//  rsp_wrt, rbp_wrt, rsi_wrt, rdi_wrt,
//  r8_wrt, r9_wrt, r10_wrt, r11_wrt,
//  r12_wrt, r13_wrt, r14_wrt;


//  // Implement with clocked registers
 
 
//  reg temp = 1'b0;
//  cenrreg #(64) rax_reg(rax, rax_dat, rax_wrt, temp, 64'b0, clock);
//  cenrreg #(64) rcx_reg(rcx, rcx_dat, rcx_wrt, temp, 64'b0, clock);
//  cenrreg #(64) rdx_reg(rdx, rdx_dat, rdx_wrt, temp, 64'b0, clock);
//  cenrreg #(64) rbx_reg(rbx, rbx_dat, rbx_wrt, temp, 64'b0, clock);
//  cenrreg #(64) rsp_reg(rsp, rsp_dat, rsp_wrt, temp, 64'b0, clock);
//  cenrreg #(64) rbp_reg(rbp, rbp_dat, rbp_wrt, temp, 64'b0, clock);
//  cenrreg #(64) rsi_reg(rsi, rsi_dat, rsi_wrt, temp, 64'b0, clock);
//  cenrreg #(64) rdi_reg(rdi, rdi_dat, rdi_wrt, temp, 64'b0, clock);
//  cenrreg #(64) r8_reg(r8, r8_dat, r8_wrt, temp, 64'b0, clock);
//  cenrreg #(64) r9_reg(r9, r9_dat, r9_wrt, temp, 64'b0, clock);
//  cenrreg #(64) r10_reg(r10, r10_dat, r10_wrt, temp, 64'b0, clock);
//  cenrreg #(64) r11_reg(r11, r11_dat, r11_wrt, temp, 64'b0, clock);
//  cenrreg #(64) r12_reg(r12, r12_dat, r12_wrt, temp, 64'b0, clock);
//  cenrreg #(64) r13_reg(r13, r13_dat, r13_wrt, temp, 64'b0, clock);
//  cenrreg #(64) r14_reg(r14, r14_dat, r14_wrt, temp, 64'b0, clock);

//  // Reads occur like combinational logic
//  assign valA =
//  srcA == RRAX ? rax :
//  srcA == RRCX ? rcx :
//  srcA == RRDX ? rdx :
//  srcA == RRBX ? rbx :
//  srcA == RRSP ? rsp :
//  srcA == RRBP ? rbp :
//  srcA == RRSI ? rsi :
//  srcA == RRDI ? rdi :
//  srcA == R8 ? r8 :
//  srcA == R9 ? r9 :
//  srcA == R10 ? r10 :
//  srcA == R11 ? r11 :
//  srcA == R12 ? r12 :
//  srcA == R13 ? r13 :
//  srcA == R14 ? r14 :
//  0;

//  assign valB =
//  srcB == RRAX ? rax :
//  srcB == RRCX ? rcx :
//  srcB == RRDX ? rdx :
//  srcB == RRBX ? rbx :

//  srcB == RRSP ? rsp :
//  srcB == RRBP ? rbp :
//  srcB == RRSI ? rsi :
//  srcB == RRDI ? rdi :
//  srcB == R8 ? r8 :
//  srcB == R9 ? r9 :
//  srcB == R10 ? r10 :
//  srcB == R11 ? r11 :
//  srcB == R12 ? r12 :
//  srcB == R13 ? r13 :
//  srcB == R14 ? r14 :
//  0;

//  assign rax_dat = dstM == RRAX ? valM : valE;
//  assign rcx_dat = dstM == RRCX ? valM : valE;
//  assign rdx_dat = dstM == RRDX ? valM : valE;
//  assign rbx_dat = dstM == RRBX ? valM : valE;
//  assign rsp_dat = dstM == RRSP ? valM : valE;
//  assign rbp_dat = dstM == RRBP ? valM : valE;
//  assign rsi_dat = dstM == RRSI ? valM : valE;
//  assign rdi_dat = dstM == RRDI ? valM : valE;
//  assign r8_dat = dstM == R8 ? valM : valE;
//  assign r9_dat = dstM == R9 ? valM : valE;
//  assign r10_dat = dstM == R10 ? valM : valE;
//  assign r11_dat = dstM == R11 ? valM : valE;
//  assign r12_dat = dstM == R12 ? valM : valE;
//  assign r13_dat = dstM == R13 ? valM : valE;
//  assign r14_dat = dstM == R14 ? valM : valE;

//  assign rax_wrt = dstM == RRAX | dstE == RRAX;
//  assign rcx_wrt = dstM == RRCX | dstE == RRCX;
//  assign rdx_wrt = dstM == RRDX | dstE == RRDX;
//  assign rbx_wrt = dstM == RRBX | dstE == RRBX;
//  assign rsp_wrt = dstM == RRSP | dstE == RRSP;
//  assign rbp_wrt = dstM == RRBP | dstE == RRBP;
//  assign rsi_wrt = dstM == RRSI | dstE == RRSI;
//  assign rdi_wrt = dstM == RRDI | dstE == RRDI;
//  assign r8_wrt = dstM == R8 | dstE == R8;
//  assign r9_wrt = dstM == R9 | dstE == R9;
//  assign r10_wrt = dstM == R10 | dstE == R10;
//  assign r11_wrt = dstM == R11 | dstE == R11;
//  assign r12_wrt = dstM == R12 | dstE == R12;
//  assign r13_wrt = dstM == R13 | dstE == R13;
//  assign r14_wrt = dstM == R14 | dstE == R14;


//  endmodule