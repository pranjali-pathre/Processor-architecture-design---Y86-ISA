`timescale 1ns / 1ps

module split_test;

	// Inputs
    reg [7:0] ibyte;
	// Outputs
	wire [3:0] icode;
    wire [3:0] ifun;
	
	// Instantiate the Unit Under Test (UUT)
	split uut (
		.ibyte(ibyte), 
		.icode(icode), 
		.ifun(ifun)
	);

	initial begin
        $dumpfile("split_test.vcd");
		// Initialize Inputs
		ibyte = 8'h3082;
		// #10  ibyte = 8'h;
        // #10  ibyte = 8'h;
		// #10  ibyte = 8'h;
        // #10  ibyte = 8'h;
        // #10  ibyte = 8'h;
	end
	
	initial
		$monitor("ibyte(%b) icode =(%b) ifun = (%b)", ibyte, icode, ifun);

endmodule