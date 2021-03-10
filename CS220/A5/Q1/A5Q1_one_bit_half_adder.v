// module for one bit half adder
module one_bit_half_adder (a, b, sum, cout);

   // inputs
   input a;    // first operand bit
   input b;    // second operand bit

   // outputs
   output sum;    // final sum bit
   wire sum;
   output cout;   // carry out bit
   wire cout;

   assign sum = a^b;
   assign cout = a&b;

endmodule