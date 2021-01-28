// Top Module for 8 bit comparator file

`include "A1Q2_eight_bit_comparator.v"

// Module Declaration
module eight_bit_comparator_top;
	
	reg [7:0] A;
	reg [7:0] B;
	reg lin, ein, gin;

	wire less, equal, greater;

	//Declare eight bit comparator module instantiation
	eight_bit_comparator comp(A, B, lin, ein, gin, less, equal, greater);

	always @(A or B or lin or ein or gin or less or equal or greater)
		begin
			$display("Time = %0t \tA = %b = %d, B = %b = %d, lin = %b, ein =%b, gin =%b, A < B = %b, A = B = %b, A > B = %b", $time, A, A, B, B, lin, ein, gin,  less, equal, greater);
		end

	//To specify finishing time
	initial
		begin
			#10 
			$finish;
		end

	// Test bench to check inputs
	initial
		begin

			//default values: 
			A = 0; B = 0; lin = 0; ein = 1; gin = 0;
			#1
			$display("\n");
			A = 8'b00001011; B = 8'b00000111; lin = 0; ein = 1; gin = 0;
			#1
			$display("\n");
			A = 8'b10001011; B = 8'b00000111; lin = 0; ein = 1; gin = 0;
			#1
			$display("\n");
			A = 8'b00001010; B = 8'b00001010; lin = 0; ein = 1; gin = 0;
			#1
			$display("\n");
			A = 8'b00001010; B = 8'b00000101; lin = 0; ein = 1; gin = 0;
			#1
			$display("\n");
			A = 8'b00000000; B = 8'b11111111; lin = 0; ein = 1; gin = 0;
			#1
			$display("\n");
			A = 8'b10101011; B = 8'b10101010; lin = 0; ein = 1; gin = 0;
			#1 
			$display("\n");
			A = 8'b10101010; B = 8'b10101011; lin = 0; ein = 0; gin = 1;
			#1
			$display("\n");
			A = 8'b10010101; B = 8'b11010000; lin = 1; ein = 0; gin = 0;
			#1
			$display("\n");
			A = 8'b10001011; B = 8'b10001011; lin = 1; ein = 0; gin = 0;
			#1
			$display("\n");
			
		end


	/*
	Can be used to visualise waveforms: 
	initial begin
		$dumpfile("comp.vcd");
		$dumpvars(-1, eight_bit_comparator_top);
		$monitor("Time = %0t \t, A = %b, B = %b, less = %b, equal = %b, greater = %b , Test ID = %0d", $time, A, B, less, equal, greater, test_id);
	end
	*/
endmodule
