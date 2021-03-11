// Module for 1 bit comparator

// Module declaration
module one_bit_comparator(bit_a, bit_b, less_in, equal_in, greater_in, less_out, equal_out, greater_out);
	
	//Input Bits
	input bit_a ;
	input bit_b ;

	//Input less, equal or greater bits till now
	input less_in;
	input equal_in;
	input greater_in;

	//Output less, equal or greater bits after this comparison
	output wire less_out;
	output wire equal_out;
	output wire greater_out;

	// Combinational logic for less_out, equal_out, greater_out
	assign less_out = ((~bit_a) & bit_b)&(equal_in) | (less_in & (~equal_in));
	assign equal_out = (~(bit_a^bit_b)) & equal_in;
	assign greater_out = ((bit_a & (~bit_b))&(equal_in)) | (greater_in & (~equal_in));

endmodule