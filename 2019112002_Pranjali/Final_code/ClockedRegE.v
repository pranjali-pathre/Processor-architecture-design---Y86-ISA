// Clocked register with enable signal.
// Default width is 8, but can be overriden
module cenreg(out, in, enable, clock);
    parameter width = 8;
    output [width-1:0] out;
    input [width-1:0] in;
    input enable;
    input clock;
cenrreg #(width) c(out, in, enable, 1’b0, 8’b0, clock);
endmodule