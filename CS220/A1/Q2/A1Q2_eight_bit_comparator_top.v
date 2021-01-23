// Top Module for 8 bit comparator file

`include "A1Q2_eight_bit_comparator.v"

// Module Declaration
module eight_bit_comparator_top;
	
	reg [7:0] A;
	reg [7:0] B;
	wire less, equal, greater;

	//Declare eight bit comparator module instantiation
	eight_bit_comparator comp(A, B, less, equal, greater);

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
			A = 0; B = 0;
			#1
			$display("Time = %0t \tA = %b = %d, B = %b = %d, less = %b, equal = %b, greater = %b", $time, A, A, B, B, less, equal, greater);
			A = 8'b00001011; B = 8'b00000111; 
			#1
			$display("Time = %0t \tA = %b = %d, B = %b = %d, less = %b, equal = %b, greater = %b", $time, A, A, B, B, less, equal, greater);
			A = 8'b10001011; B = 8'b00000111; 
			#1
			$display("Time = %0t \tA = %b = %d, B = %b = %d, less = %b, equal = %b, greater = %b", $time, A, A, B, B, less, equal, greater);
			A = 8'b00001010; B = 8'b00001010;
			#1
			$display("Time = %0t \tA = %b = %d, B = %b = %d, less = %b, equal = %b, greater = %b", $time, A, A, B, B, less, equal, greater);
			A = 8'b00001010; B = 8'b00000101;
			#1
			$display("Time = %0t \tA = %b = %d, B = %b = %d, less = %b, equal = %b, greater = %b", $time, A, A, B, B, less, equal, greater);
			A = 8'b00000000; B = 8'b11111111;
			#1
			$display("Time = %0t \tA = %b = %d, B = %b = %d, less = %b, equal = %b, greater = %b", $time, A, A, B, B, less, equal, greater);
			A = 8'b10101011; B = 8'b10101010;
			#1 
			$display("Time = %0t \tA = %b = %d, B = %b = %d, less = %b, equal = %b, greater = %b", $time, A, A, B, B, less, equal, greater);
			A = 8'b10101010; B = 8'b10101011;
			#1
			$display("Time = %0t \tA = %b = %d, B = %b = %d, less = %b, equal = %b, greater = %b", $time, A, A, B, B, less, equal, greater);
			A = 8'b10010101; B = 8'b11010000;
			#1
			$display("Time = %0t \tA = %b = %d, B = %b = %d, less = %b, equal = %b, greater = %b", $time, A, A, B, B, less, equal, greater);
			A = 8'b10001011; B = 8'b10001011;
			#1
			$display("Time = %0t \tA = %b = %d, B = %b = %d, less = %b, equal = %b, greater = %b", $time, A, A, B, B, less, equal, greater);
			
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