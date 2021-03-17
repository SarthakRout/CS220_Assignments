// module for one bit adder/subtracter
module one_bit_adder_subtracter(a, b, cin, opcode, sum, carry);
    input a,b,cin,opcode;   // a,b -> operands, cin -> carry in, opcode -> operation code
    output wire sum, carry; // sum -> a \operation b, carry out
    wire b_dummy;   // additional dummy variable stores b^opcode

    assign b_dummy = b^opcode;
    assign sum = a^b_dummy^cin;
    assign carry = (a&b_dummy) | (b_dummy&cin) | (cin&a);
endmodule