// module for eight bit adder/subtracter
module five_bit_adder_subtracter (a, b, opcode, sum, carry, overflow);
    input [4:0] a, b;   // operands
    input opcode;       // operation code
    output wire [4:0] sum;  // output of operation
    output wire carry, overflow;    // carry over and overflow

    wire [3:0] intermediate_carry;  // required dummy variable.

    one_bit_adder_subtracter AB0 (a[0], b[0], opcode, opcode, sum[0], intermediate_carry[0]);
    one_bit_adder_subtracter AB1 (a[1], b[1], intermediate_carry[0], opcode, sum[1], intermediate_carry[1]);
    one_bit_adder_subtracter AB2 (a[2], b[2], intermediate_carry[1], opcode, sum[2], intermediate_carry[2]);
    one_bit_adder_subtracter AB3 (a[3], b[3], intermediate_carry[2], opcode, sum[3], intermediate_carry[3]);
    one_bit_adder_subtracter AB7 (a[4], b[4], intermediate_carry[3], opcode, sum[4], carry);

    assign overflow = intermediate_carry[3]^carry;
endmodule