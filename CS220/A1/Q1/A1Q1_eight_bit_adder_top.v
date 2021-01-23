module eight_bit_adder_top;

   reg [7:0] A;
   reg [7:0] B;
   reg Cin;

   wire [7:0] Sum;
   wire Carry;

   eight_bit_adder ADDER (A, B, Cin, Sum, Carry);

   always @ (A or B or Cin) begin
       $display("time: %d, %d + %d + %b = %d, carry = %b\n", $time, A, B, Cin, Sum, Carry);
   end

   initial begin
       #100
       $finish;
   end

   initial begin
       A = 8'h00; B = 8'h00; Cin = 0;
       #5
       A = 8'h12; B = 8'h23; Cin = 0;
       #5
       A = 8'haf; B = 8'h01; Cin = 0;
       #5
       A = 8'h00; B = 8'h00; Cin = 0;
       #5
       A = 8'h00; B = 8'h00; Cin = 0;
       #5
       A = 8'h00; B = 8'h00; Cin = 0;
       #5
       A = 8'h00; B = 8'h00; Cin = 0;
       #5
       A = 8'h00; B = 8'h00; Cin = 0;
       #5
       A = 8'h00; B = 8'h00; Cin = 0;
       #5
       A = 8'h00; B = 8'h00; Cin = 0;
   end

endmodule