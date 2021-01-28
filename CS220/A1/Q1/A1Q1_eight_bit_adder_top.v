// module using eight bit adder
module eight_bit_adder_top;

   reg [7:0] A; // stored 1st 8-bit operand
   reg [7:0] B; // stores 2nd 8-bit operand
   reg Cin;     // carry-in bit

   wire [7:0] Sum;  // contains final sum
   wire Carry;      // contains carry over

   eight_bit_adder ADDER (A, B, Cin, Sum, Carry);

   always @ (A or B or Cin or Sum or Carry) begin
       $display("time = %d, %d + %d + %b = %d, carry = %b", $time, A, B, Cin, Sum, Carry);
   end

   initial begin
       #10
       $finish;
   end

    // testing the 8-bit adder with 10 test cases. 
   initial begin
      A = 100; B = 100; Cin = 1;
      #1
      $display("\n");
      A = 200; B = 200; Cin = 0;
      #1
      $display("\n");
      A = 20; B = 200; Cin = 0;
      #1
      $display("\n");
      A = 24; B = 78; Cin = 1;
      #1
      $display("\n");
      A = 223; B = 219; Cin = 0;
      #1
      $display("\n");
      A = 255; B = 255; Cin = 1;
      #1
      $display("\n");
      A = 0; B = 0; Cin = 0;
      #1
      $display("\n");
      A = 43; B = 89; Cin = 0;
      #1
      $display("\n");
      A = 128; B = 127; Cin = 1;
      #1
      $display("\n");
      A = 56; B = 200; Cin = 0;
   end

endmodule