// module for 8 bit adder/subtracter
module eight_bit_add_sub (a, b, opcode, sum);
    input [7:0] a, b;   								// operands
    input opcode;       								// operation code
    output wire [7:0] sum;  							// output of operation
    wire carry, overflow;    							// Ignored carry over and overflow

    wire [6:0] intermediate_carry;  					// required dummy variable.

    one_bit_adder_subtracter AB0 (a[0], b[0], opcode, opcode, sum[0], intermediate_carry[0]);
    one_bit_adder_subtracter AB1 (a[1], b[1], intermediate_carry[0], opcode, sum[1], intermediate_carry[1]);
    one_bit_adder_subtracter AB2 (a[2], b[2], intermediate_carry[1], opcode, sum[2], intermediate_carry[2]);
    one_bit_adder_subtracter AB3 (a[3], b[3], intermediate_carry[2], opcode, sum[3], intermediate_carry[3]);
    one_bit_adder_subtracter AB4 (a[4], b[4], intermediate_carry[3], opcode, sum[4], intermediate_carry[4]);
    one_bit_adder_subtracter AB5 (a[5], b[5], intermediate_carry[4], opcode, sum[5], intermediate_carry[5]);
    one_bit_adder_subtracter AB6 (a[6], b[6], intermediate_carry[5], opcode, sum[6], intermediate_carry[6]);
    one_bit_adder_subtracter AB15 (a[7], b[7], intermediate_carry[6], opcode, sum[7], carry);

    assign overflow = intermediate_carry[6]^carry;
endmodule