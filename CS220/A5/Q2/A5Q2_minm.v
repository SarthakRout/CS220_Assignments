// Module to calculate index of min element.

module minm(A0, A1, A2, A3, out);

    // 4 3-bit inputs
    input [2:0] A0;
    input [2:0] A1;
    input [2:0] A2;
    input [2:0] A3;

    // stores least index
    output wire [1:0] out;

    wire l0, l1, l2;
    wire [2:0] B0;  // stores min of A0 and A1.
    wire [2:0] B1;  // stores min of A2 and A3.

    three_bit_comparator c1(A1, A0, l0);
    three_bit_comparator c2(A3, A2, l1);

    assign B0[0] = ((l0 & A1[0]) | ((~l0) & A0[0]));
    assign B0[1] = ((l0 & A1[1]) | ((~l0) & A0[1]));
    assign B0[2] = ((l0 & A1[2]) | ((~l0) & A0[2]));

    assign B1[0] = ((l1 & A3[0]) | ((~l1) & A2[0]));
    assign B1[1] = ((l1 & A3[1]) | ((~l1) & A2[1]));
    assign B1[2] = ((l1 & A3[2]) | ((~l1) & A2[2]));

    three_bit_comparator c3(B1, B0, l2);

    assign out[1] = l2;
    assign out[0] = ((l2 & l1) | ((~l2) & l0));

endmodule