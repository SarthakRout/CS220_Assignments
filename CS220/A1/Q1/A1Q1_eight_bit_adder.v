// module for eight bit adder
module eight_bit_adder (x, y, carry_in, sum, carry_out);

   // inputs
   input [7:0] x;    // 1st eight-bit operand
   input [7:0] y;    // 2nd eight-bit operand
   input carry_in;   // carry in bit

   // outputs
   output [7:0] sum; // 8-bit sum
   wire [7:0] sum;
   output carry_out; // carry-out bit
   wire carry_out;

   wire [6:0] intermediate_carry;

   // connecting 8 one-bit adders to make eight bit adder
   one_bit_full_adder FA0 (x[0], y[0], carry_in, sum[0], intermediate_carry[0]);
   one_bit_full_adder FA1 (x[1], y[1], intermediate_carry[0], sum[1], intermediate_carry[1]);
   one_bit_full_adder FA2 (x[2], y[2], intermediate_carry[1], sum[2], intermediate_carry[2]);
   one_bit_full_adder FA3 (x[3], y[3], intermediate_carry[2], sum[3], intermediate_carry[3]);
   one_bit_full_adder FA4 (x[4], y[4], intermediate_carry[3], sum[4], intermediate_carry[4]);
   one_bit_full_adder FA5 (x[5], y[5], intermediate_carry[4], sum[5], intermediate_carry[5]);
   one_bit_full_adder FA6 (x[6], y[6], intermediate_carry[5], sum[6], intermediate_carry[6]);
   one_bit_full_adder FA7 (x[7], y[7], intermediate_carry[6], sum[7], carry_out);

endmodule