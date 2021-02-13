// Copied from Assignment 1 Q1 Full Adder 
// module for one bit adder
module one_bit_adder (a, b, cin, sum, cout);

   // inputs
   input a;    // first operand bit
   input b;    // second operand bit
   input cin;  // carry in bit

   // outputs
   output sum;    // final sum bit
   wire sum;
   output cout;   // carry out bit
   wire cout;

   assign sum = a^b^cin;
   assign cout = (a|b)&(b|cin)&(cin|a);

endmodule