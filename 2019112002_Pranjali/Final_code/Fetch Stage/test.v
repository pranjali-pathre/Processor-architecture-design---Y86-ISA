`timescale 1ns / 1ps

module main_test;
    reg [79:0] temp_input;
    main uut(
        .ibytes(ibytes[79:8])
	);

	initial begin
        $dumpfile("main_test.vcd");
		temp_input = 80'h0000000000000008f830;
	end
    initial
		$monitor("ibytes(%h) need_regids(%h) rA(%h) rB(%h) valC(%h)", ibytes[79:8], need_regids, rA, rB, valC);
endmodule