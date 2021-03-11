// Module for 3 bit comparator

// Module declaration
module three_bit_comparator(A, B, less);
	
	input [2:0] A;
	input [2:0] B;

	output wire less, equal, greater;

    wire lin, ein, gin;

	wire [7:0] less_3;
	wire [7:0] equal_3;
	wire [7:0] greater_3;

    assign lin = 0;
    assign ein = 1;
    assign gin = 0;

	// One bit comparator for MSB (3rd) position
	one_bit_comparator c2(A[2], B[2], lin, ein, gin, less_3[2], equal_3[2], greater_3[2]);
	one_bit_comparator c1(A[1], B[1], less_3[2], equal_3[2], greater_3[2], less_3[1], equal_3[1], greater_3[1]);
	one_bit_comparator c0(A[0], B[0], less_3[1], equal_3[1], greater_3[1], less_3[0], equal_3[0], greater_3[0]);
	
	assign less = less_3[0];

endmodule