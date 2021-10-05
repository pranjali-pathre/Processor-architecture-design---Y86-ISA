`timescale 1ns / 1ps
module processor_test;

    reg clock = 0;
	wire [2:0] status;
	
	processor uut (
		.clock(clock),
		.status(status)
    );

	initial begin
		// Initialize Inputs
		$dumpfile("processor_test.vcd");
		$dumpvars(0,processor_test);
		// #10;
		// clock = 1;
		// #10;
		// clock = 0;
		// #10;
		// clock = 1;
		// #10;
		// clock = 0;
		// #10;
		// clock = 1;
		// #10;

	end

	always #10 clock = ~clock;
	always @(posedge clock)
	begin
		if(status == 2'h2)
			$finish;
	end     
endmodule