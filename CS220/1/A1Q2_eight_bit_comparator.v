// Module for 8 bit comparator

`include "A1Q2_one_bit_comparator.v"

// Module declaration
module eight_bit_comparator(A, B, less, equal, greater);
	
	input [7:0] A;
	input [7:0] B;

	output wire less, equal, greater;

	wire [7:0] less_8;
	wire [7:0] equal_8;
	wire [7:0] greater_8;

	// One bit comparator for MSB (7th) position
	one_bit_comparator cmsb(A[7], B[7], 1'b0, 1'b1, 1'b0, less_8[7], equal_8[7], greater_8[7]);

	// Compile time loop for module instantiation of other 7 positions
	genvar i;
	generate
		for (i = 0 ; i<7; i = i + 1) begin : bit_comp
			one_bit_comparator c0(A[i], B[i], less_8[i+1], equal_8[i+1], greater_8[i+1], less_8[i], equal_8[i], greater_8[i]);
		end 
	endgenerate
	
	
	assign less = less_8[0];
	assign equal = equal_8[0];
	assign greater = greater_8[0];

endmodule