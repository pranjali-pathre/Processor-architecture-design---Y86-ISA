`timescale 1ns / 1ps

module align_test;

	// Inputs
    reg [79:0] ibytes;
	reg need_regids;
	// Outputs
	wire [3:0] rA;
    wire [3:0] rB;
	wire [63:0] valC;
	
	// Instantiate the Unit Under Test (UUT)
	align uut (
		.ibytes(ibytes[79:8]), 
		.need_regids(need_regids), 
		.rA(rA),
		.rB(rB),
		.valC(valC)
	);

	initial begin
        $dumpfile("align_test.vcd");
		// Initialize Inputs
		ibytes = 80'h0000000000000008f830;
		need_regids = 1'b1;
	end
	
	initial
		$monitor("ibytes(%h) need_regids(%h) rA(%h) rB(%h) valC(%h)", ibytes[79:8], need_regids, rA, rB, valC);

endmodule