// Clocked register with enable signal and synchronous reset
// Default width is 8, but can be changed
module clcreg64(output [63:0] out, input [63:0] in, input enable, input reset, input [63:0] value, input clock);
    reg [63:0] out;
    always
    // Flush the required value in the out reg depending on the reset and enable on every positive edge of clock.
        @(posedge clock)
        begin
        // Reset if the reselt value is 1 i.e., out=value else if enable is 1 in=out
        if (reset)
            out <= value;
        else if (enable)
            out <= in;
        end
endmodule

// Clocked register with enable signal and synchronous reset
// Default width is 4, but can be changed
module clcreg4(output [3:0] out, input [3:0] in, input enable, input reset, input [3:0] value, input clock);
    reg [3:0] out;
    always
    // Flush the required value in the out reg depending on the reset and enable on every positive edge of clock.
        @(posedge clock)
        begin
        // Reset if the reselt value is 1 i.e., out=value else if enable is 1 in=out
        if (reset)
            out <= value;
        else if (enable)
            out <= in;
        end
endmodule

module clcreg3(output [2:0] out, input [2:0] in, input enable, input reset, input [2:0] value, input clock);
    reg [2:0] out;
    always
    // Flush the required value in the out reg depending on the reset and enable on every positive edge of clock.
        @(posedge clock)
        begin
        // Reset if the reselt value is 1 i.e., out=value else if enable is 1 in=out
        if (reset)
            out <= value;
        else if (enable)
            out <= in;
        end
endmodule

module clcreg1(output out, input in, input enable, input reset, input value, input clock);
    reg out;
    always
    // Flush the required value in the out reg depending on the reset and enable on every positive edge of clock.
        @(posedge clock)
        begin
        // Reset if the reselt value is 1 i.e., out=value else if enable is 1 in=out
        if (reset)
            out <= value;
        else if (enable)
            out <= in;
        end
endmodule

// Bubble is injected using the indicator as reset signal. Also we must specify the value that will be loaded 
module pipelinedreg64(output [63:0] out, input [63:0]  in, input stall, input [63:0] bubbleval, input clock);
    reg [63:0] out;
    initial begin 
     out <= bubbleval;
 end
 always @(posedge clock) begin
    if (!stall)
        out <= in;
    end
endmodule

module pipelinedreg4(output [3:0] out, input [3:0]  in, input stall, input [3:0] bubbleval, input clock);
    reg [3:0] out;
    initial begin 
     out <= bubbleval;
 end
 always @(posedge clock) begin
    if (!stall)
        out <= in;
    end

endmodule

module pipelinedreg3(output [2:0] out, input [2:0]  in, input stall,  input [2:0] bubbleval, input clock);
    reg [2:0] out;
    initial begin 
     out <= bubbleval;
 end
 always @(posedge clock) begin
    if (!stall)
        out <= in;
    end
endmodule

module pipelinedreg1(output out, input  in, input stall,  input bubbleval, input clock);
    reg out;
    initial begin 
     out <= bubbleval;
 end
 always @(posedge clock) begin
    if (!stall)
        out <= in;
    end
endmodule

module pipelinedregnew(output [3:0] out, input [3:0]  in, input stall, input bubble,input [3:0] bubbleval, input clock);
    reg [3:0] out;
    initial begin 
     out <= bubbleval;
 end
 always @(posedge clock) begin
    if (!stall && !bubble)
        out <= in;
   
    else if (!stall && bubble)
        out<=bubbleval;
    end

endmodule


