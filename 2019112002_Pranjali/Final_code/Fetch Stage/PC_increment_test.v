`timescale 1ns / 1ps

module align_test;

	// Inputs
    reg [63:0] pc;
	reg need_regids;
	reg need_valC;
	// Outputs
	wire [63:0] valP;
	
	// Instantiate the Unit Under Test (UUT)
	PC_increment uut (
		.pc(pc), 
		.need_regids(need_regids), 
		.need_valC(need_valC),
		.valP(valP)
	);

	initial begin
        $dumpfile("PC_increment_test.vcd");
		// Initialize Inputs
		need_regids = 1'b1;
		need_valC = 1'b1;
		pc = 64'h0038;
	end
	
	initial
		$monitor("pc(%h) need_regids(%b) need_valC(%b) valP(%h)", pc, need_regids, need_valC, valP);

endmodule