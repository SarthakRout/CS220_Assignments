// Module for 5-bit adder/subtracter

module five_bit_add_sub(op, in_1, in_2, out);
	
	input op;
	input [4:0] in_1;
	input [4:0] in_2;

	output wire [4:0] out;

	wire [4:0] in_2_masked;
	wire [4:0] intermediate_carry;

	assign in_2_masked = ({5{op}} ^ in_2);

	one_bit_adder FA0 (in_1[0], in_2_masked[0], op, out[0], intermediate_carry[0]);
   	one_bit_adder FA1 (in_1[1], in_2_masked[1], intermediate_carry[0], out[1], intermediate_carry[1]);
   	one_bit_adder FA2 (in_1[2], in_2_masked[2], intermediate_carry[1], out[2], intermediate_carry[2]);
   	one_bit_adder FA3 (in_1[3], in_2_masked[3], intermediate_carry[2], out[3], intermediate_carry[3]);
   	one_bit_adder FA4 (in_1[4], in_2_masked[4], intermediate_carry[3], out[4], intermediate_carry[4]);

endmodule