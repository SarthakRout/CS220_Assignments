// module for 16 bit adder/subtracter
module add_sub (a, b, opcode, sum);
    input [15:0] a, b;   // operands
    input opcode;       // operation code
    output wire [15:0] sum;  // output of operation
    wire carry, overflow;    // Ignored carry over and overflow

    wire [14:0] intermediate_carry;  // required dummy variable.

    one_bit_adder_subtracter AB0 (a[0], b[0], opcode, opcode, sum[0], intermediate_carry[0]);
    one_bit_adder_subtracter AB1 (a[1], b[1], intermediate_carry[0], opcode, sum[1], intermediate_carry[1]);
    one_bit_adder_subtracter AB2 (a[2], b[2], intermediate_carry[1], opcode, sum[2], intermediate_carry[2]);
    one_bit_adder_subtracter AB3 (a[3], b[3], intermediate_carry[2], opcode, sum[3], intermediate_carry[3]);
    one_bit_adder_subtracter AB4 (a[4], b[4], intermediate_carry[3], opcode, sum[4], intermediate_carry[4]);
    one_bit_adder_subtracter AB5 (a[5], b[5], intermediate_carry[4], opcode, sum[5], intermediate_carry[5]);
    one_bit_adder_subtracter AB6 (a[6], b[6], intermediate_carry[5], opcode, sum[6], intermediate_carry[6]);
    one_bit_adder_subtracter AB7 (a[7], b[7], intermediate_carry[6], opcode, sum[7], intermediate_carry[7]);
    one_bit_adder_subtracter AB8 (a[8], b[8], intermediate_carry[7], opcode, sum[8], intermediate_carry[8]);
    one_bit_adder_subtracter AB9 (a[9], b[9], intermediate_carry[8], opcode, sum[9], intermediate_carry[9]);
    one_bit_adder_subtracter AB10 (a[10], b[10], intermediate_carry[9], opcode, sum[10], intermediate_carry[10]);
    one_bit_adder_subtracter AB11 (a[11], b[11], intermediate_carry[10], opcode, sum[11], intermediate_carry[11]);
    one_bit_adder_subtracter AB12 (a[12], b[12], intermediate_carry[11], opcode, sum[12], intermediate_carry[12]);
    one_bit_adder_subtracter AB13 (a[13], b[13], intermediate_carry[12], opcode, sum[13], intermediate_carry[13]);
    one_bit_adder_subtracter AB14 (a[14], b[14], intermediate_carry[13], opcode, sum[14], intermediate_carry[14]);
    one_bit_adder_subtracter AB15 (a[15], b[15], intermediate_carry[14], opcode, sum[15], carry);

    assign overflow = intermediate_carry[14]^carry;
endmodule