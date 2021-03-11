// module for four bit incrementer
module four_bit_incrementer (x, sum);

   // inputs
   input [3:0] x;    // one four-bit operand

   // outputs
   output [3:0] sum; // 4-bit sum
   wire [3:0] sum;
   // output carry_out; // carry-out bit ( not used in the implementation )
   wire carry_out;

   wire [2:0] intermediate_carry;

   // connecting 4 one-bit half adders to make four bit incrementer
   one_bit_half_adder HA0 (x[0], 1'b1, sum[0], intermediate_carry[0]);
   one_bit_half_adder HA1 (x[1], intermediate_carry[0], sum[1], intermediate_carry[1]);
   one_bit_half_adder HA2 (x[2], intermediate_carry[1], sum[2], intermediate_carry[2]);
   one_bit_half_adder HA3 (x[3], intermediate_carry[2], sum[3], carry_out);

endmodule