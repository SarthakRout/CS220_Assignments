// Module for 8 bit comparator

// Module declaration
module eight_bit_comparator(A, B, less, equal, greater);
	
	input [7:0] A;
	input [7:0] B;

	wire lin, ein, gin;

	assign lin = 0;
	assign ein = 1;
	assign gin = 0;

	output wire less, equal, greater;

	wire [7:0] less_8;
	wire [7:0] equal_8;
	wire [7:0] greater_8;

	// One bit comparator for MSB (7th) position
	one_bit_comparator c7(A[7], B[7], lin, ein, gin, less_8[7], equal_8[7], greater_8[7]);
	one_bit_comparator c6(A[6], B[6], less_8[7], equal_8[7], greater_8[7], less_8[6], equal_8[6], greater_8[6]);
	one_bit_comparator c5(A[5], B[5], less_8[6], equal_8[6], greater_8[6], less_8[5], equal_8[5], greater_8[5]);
	one_bit_comparator c4(A[4], B[4], less_8[5], equal_8[5], greater_8[5], less_8[4], equal_8[4], greater_8[4]);
	one_bit_comparator c3(A[3], B[3], less_8[4], equal_8[4], greater_8[4], less_8[3], equal_8[3], greater_8[3]);
	one_bit_comparator c2(A[2], B[2], less_8[3], equal_8[3], greater_8[3], less_8[2], equal_8[2], greater_8[2]);
	one_bit_comparator c1(A[1], B[1], less_8[2], equal_8[2], greater_8[2], less_8[1], equal_8[1], greater_8[1]);
	one_bit_comparator c0(A[0], B[0], less_8[1], equal_8[1], greater_8[1], less_8[0], equal_8[0], greater_8[0]);



	/* Compile time loop for module instantiation of other 7 positions
	genvar i;
	generate
		for (i = 0 ; i<7; i = i + 1) begin : bit_comp
			one_bit_comparator c0(A[i], B[i], less_8[i+1], equal_8[i+1], greater_8[i+1], less_8[i], equal_8[i], greater_8[i]);
		end 
	endgenerate
	*/
	
	
	assign less = less_8[0];
	assign equal = equal_8[0];
	assign greater = greater_8[0];

endmodule